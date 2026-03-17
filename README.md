# 📝 Todo List App

Ứng dụng quản lý công việc (To-do List) được phát triển bằng **Flutter**, hỗ trợ đa ngôn ngữ (Tiếng Việt & Tiếng Anh).
## 👨‍💻 Nhóm phát triển

| Họ và tên | MSSV | Vai trò |
|---|---|---|
| **Từ Hữu Minh Vũ** | 23010076 | Project Manager |
| **Phạm Thị Minh Ngọc** | 23010167 | Developer |
---


## 📱 Màn hình chính

| Màn hình | Mô tả |
|---|---|
| 🔐 **Đăng nhập** | Xác thực người dùng bằng email & mật khẩu |
| 🏠 **Trang chủ** | Danh sách công việc, thanh tiến trình hoàn thành |
| ➕ **Thêm task** | Thêm công việc mới qua hộp thoại popup |
| 📅 **Lịch** | Xem công việc theo dạng lịch tháng |
| 👤 **Hồ sơ** | Thông tin người dùng và thống kê task |
| ℹ️ **Giới thiệu** | Thông tin ứng dụng và nhóm phát triển |

---

## ✨ Tính năng nổi bật

- ✅ **Quản lý công việc**: Thêm, xem, đánh dấu hoàn thành task
- 📊 **Thanh tiến trình**: Hiển thị số task hoàn thành / tổng số
- 📅 **Xem theo lịch**: Tích hợp `table_calendar` để lọc task theo ngày
- 🌐 **Đa ngôn ngữ**: Chuyển đổi ngay lập tức giữa Tiếng Việt và Tiếng Anh (`easy_localization`)
- 🔒 **Đăng nhập & đăng xuất**: Luồng xác thực với dữ liệu mock
- 🎨 **Giao diện Material Design**: Màu chủ đạo xanh lá, card bo tròn, hiệu ứng bóng đổ

---

## 📸 Giao diện ứng dụng

### 🔐 Màn hình Đăng nhập
<img src="imgs/login.png" width="280" alt="Màn hình đăng nhập"/>

> **Mô tả:** Màn hình chào mừng với hình minh họa lịch & công việc ở trên. Phía dưới gồm 2 ô nhập **Email** và **Mật khẩu** (có nút hiện/ẩn mật khẩu), nút **Login** màu xanh nổi bật và liên kết **Register**. Góc trên phải cho phép chuyển ngôn ngữ **VI / EN**.

---

### 🏠 Màn hình Danh sách Công việc (Tasks)
<img src="imgs/homescr.png" width="280" alt="Màn hình danh sách công việc"/>

> **Mô tả:** AppBar xanh hiển thị avatar + tên người dùng, nút chuyển ngôn ngữ và nút đăng xuất. Bên dưới là **thanh tiến trình** (progress bar) cho biết số task đã hoàn thành / tổng số. Danh sách mỗi task là một card trắng bo góc gồm: ảnh minh họa, tên công việc, thời gian tạo và nút **check** hoàn thành (tick xanh khi done, gạch ngang tên). Nút **+** nổi góc dưới phải để thêm task mới.

---

### 📅 Màn hình Lịch (Calendar)
<img src="imgs/lichscr.png" width="280" alt="Màn hình lịch"/>

> **Mô tả:** Hiển thị **lịch tháng** tương tác — có thể chuyển tháng bằng nút `<` `>`. Các ngày có task được đánh dấu bằng **chấm xanh** bên dưới. Khi chọn một ngày, phía dưới liệt kê các task trong ngày đó kèm số lượng. Mỗi task hiển thị ảnh icon và tên công việc.

---

### 👤 Màn hình Hồ sơ (Profile)
<img src="imgs/profile.png" width="280" alt="Màn hình hồ sơ"/>

> **Mô tả:** Hiển thị **avatar tròn** của người dùng, họ tên và email. Bên dưới là **widget thống kê** nền tím — hiện **tổng số lượng công việc** với số to ở giữa. Giao diện thoáng, tập trung vào thông tin cá nhân.

---

### ℹ️ Màn hình Giới thiệu (About)
<img src="imgs/about.png" width="280" alt="Màn hình giới thiệu"/>

> **Mô tả:** Gồm 2 card trắng bo góc: card **Về ứng dụng** mô tả chức năng chính, và card **Team phát triển** liệt kê từng thành viên với ảnh avatar tròn, họ tên, MSSV, badge vai trò màu xanh và mô tả đóng góp.

---

## 🏗️ Cấu trúc dự án

```
lib/
├── main.dart               # Điểm khởi chạy ứng dụng
├── const/
│   └── color.dart          # Bảng màu toàn cục
├── models/
│   ├── task.dart           # Model công việc
│   └── user.dart           # Model người dùng
├── data/
│   ├── mock_tasks.dart     # Dữ liệu mẫu công việc
│   └── mock_users.dart     # Dữ liệu mẫu người dùng
├── screens/
│   ├── login_screen.dart   # Màn hình đăng nhập
│   ├── home_screen.dart    # Màn hình chính (điều hướng)
│   ├── calendar_screen.dart# Màn hình lịch
│   ├── profile_screen.dart # Màn hình hồ sơ
│   ├── about_screen.dart   # Màn hình giới thiệu
│   └── todo_list_screen.dart
└── widgets/                # Các widget tái sử dụng

assets/
└── translations/
    ├── vi.json             # Ngôn ngữ Tiếng Việt
    └── en.json             # Ngôn ngữ Tiếng Anh

imgs/                       # Hình ảnh & icon của ứng dụng
```

---

## 📦 Thư viện sử dụng

| Package | Phiên bản | Mục đích |
|---|---|---|
| `easy_localization` | ^3.0.5 | Đa ngôn ngữ (VI / EN) |
| `table_calendar` | ^3.1.2 | Lịch tháng tương tác |
| `cupertino_icons` | ^1.0.8 | Bộ icon iOS |

---

## 🚀 Hướng dẫn chạy dự án

### Yêu cầu
- Flutter SDK `^3.10.4`
- Dart SDK tương thích
- Android Studio / VS Code có cài Flutter extension

### Các bước

```bash
# 1. Clone dự án về máy
git clone <repository-url>
cd du_an_todolist

# 2. Cài đặt các dependencies
flutter pub get

# 3. Chạy ứng dụng
flutter run
```

### Tài khoản demo

> Dữ liệu người dùng hiện tại là mock data. Dùng một trong các tài khoản sau để đăng nhập:

| Email | Mật khẩu |
|---|---|
| *(xem file `lib/data/mock_users.dart`)* | *(xem file tương ứng)* |

---



---

## 📄 Giấy phép

Dự án được phát triển phục vụ mục đích học tập — Môn **Lập trình Di động**, Năm học 2024–2025.

© 2025 Nhóm phát triển Todo List App. All rights reserved.
