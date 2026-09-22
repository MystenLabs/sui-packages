module 0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::display {
    public fun setup_displays(arg0: &0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::AchievementRegistry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &mut 0x2::package::Publisher, arg3: &mut 0x2::display_registry::DisplayRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::authority::assert_admin_cap(0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::registry::borrow_uid(arg0), arg1);
        let (v0, v1) = 0x2::display_registry::new_with_publisher<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(arg3, arg2, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{achievement_id}"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Aftermath achievement"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cdn.aftermath.finance/achievements/soft-emboss/badge-rare.png"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(&mut v3, &v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://aftermath.finance/achievements"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(&mut v3, &v2, 0x1::string::utf8(b"achievement_id"), 0x1::string::utf8(b"{achievement_id}"));
        0x2::display_registry::share<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::instance::AchievementInstance>>(v2, 0x2::tx_context::sender(arg4));
        let (v4, v5) = 0x2::display_registry::new_with_publisher<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(arg3, arg2, arg4);
        let v6 = v5;
        let v7 = v4;
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&mut v7, &v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Aftermath Level {level}"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&mut v7, &v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"7b616368696576656d656e745f636f756e747d20616368696576656d656e747320c2b7207b78707d205850"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&mut v7, &v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cdn.aftermath.finance/achievements/soft-emboss/level.png"));
        0x2::display_registry::set<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(&mut v7, &v6, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://aftermath.finance/achievements"));
        0x2::display_registry::share<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>(v7);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<0x7c7383c1e967716668c53b917c9664356a47ed9a766a1f7635650dee7a0ff8ba::progress::UserProgress>>(v6, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

