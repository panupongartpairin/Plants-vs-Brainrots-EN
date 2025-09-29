--==========================================================
-- UFO HUB X • ใช้ธีมกำหนดเอง (เขียว/ดำ) กับ Kavo UI — ไม่ต้องแก้ source.lua
-- ก็อปวางแล้วขึ้นสีทันที
--==========================================================

-- 1) โหลด Kavo
local Library = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/panupongartpairin/UFO-HUB-X-UI/refs/heads/main/UFO%20HUB%20X%20UI.lua"
))()

-- 2) สร้างหน้าต่าง + ส่ง "ตารางธีม" เข้าไป (สำคัญ: ต้องเป็นตาราง ไม่ใช่สตริง)
local Window = Library.CreateLib("UFO  HUB X", {
    SchemeColor  = Color3.fromRGB(0,255,140), -- เขียวเรือง (ส่งผลกับปุ่ม/ไอคอน/เส้นเน้น)
    Background   = Color3.fromRGB(16,16,16),  -- ฉากหลังหลัก
    Header       = Color3.fromRGB(0,0,0),     -- แถบหัว
    TextColor    = Color3.fromRGB(235,235,235),
    ElementColor = Color3.fromRGB(22,22,22)   -- การ์ด/กล่อง/ปุ่มพื้นฐาน
})

-- 3) ตัวอย่างโครง (แท็บ/เซคชัน) ให้เห็นสีชัด
local Tab = Window:NewTab("Home")
local Sec = Tab:NewSection("Main Controls")

Sec:NewButton("Sample Button", "ปุ่มตัวอย่างให้เห็นสี", function()
    print("[UFO HUB X] Clicked")
end)

Sec:NewToggle("Sample Toggle (OFF)", "ท็อกเกิลตัวอย่าง", function(state)
    print("[UFO HUB X] Toggle =", state and "ON" or "OFF")
end)

-- 4) (ทางเลือก) ถ้าอยากให้มี “ขอบเขียว” รอบกรอบ/ปุ่มเหมือนในภาพเดิม ให้เติม UIStroke
task.delay(0.2, function()
    local cg = game:GetService("CoreGui")
    local gui
    for _, g in ipairs(cg:GetChildren()) do
        if g:IsA("ScreenGui") and g:FindFirstChild("Main", true) then gui = g break end
    end
    if not gui then return end

    local GREEN = Color3.fromRGB(0,255,140)
    local function stroke(o, thk, r)
        if not o:IsA("GuiObject") then return end
        local s = o:FindFirstChild("UFOStroke") or Instance.new("UIStroke")
        s.Name = "UFOStroke"
        s.Parent = o
        s.Color = GREEN
        s.Thickness = thk or 2
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.LineJoinMode = Enum.LineJoinMode.Round
        (o:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", o)).CornerRadius = UDim.new(0, r or 8)
    end

    for _, o in ipairs(gui:GetDescendants()) do
        if o:IsA("Frame") or o:IsA("ScrollingFrame") or o:IsA("TextButton") or o:IsA("ImageButton") then
            stroke(o, 2, 8)
        end
    end

    local main = gui:FindFirstChild("Main", true)
    if main then stroke(main, 3, 10) end
end)

-- Hotkey ซ่อน/โชว์ (RightShift)
do
    local UIS = game:GetService("UserInputService")
    local cg  = game:GetService("CoreGui")
    local visible = true
    local function setVisible(v) local g = cg:FindFirstChildWhichIsA("ScreenGui") if g then g.Enabled = v end end
    UIS.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
            visible = not visible; setVisible(visible)
        end
    end)
end
