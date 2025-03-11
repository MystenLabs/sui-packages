module 0xb2f6958cf7e3c77e8193add15d874275fdd6734afbfb6c763488e3b766581505::beta_badge {
    struct BETA_BADGE has drop {
        dummy_field: bool,
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::ControlledPublisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::get_publisher(arg1, arg2);
        let v2 = v0;
        0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::update_authorized_publisher<BETA_BADGE>(arg0, arg1, arg2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"tier_level"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{badge_name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://a1.moviepassblack.com/w3/badges/beta_badge/image_url.png"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://a1.moviepassblack.com/w3/badges/beta_badge/thumbnail_url.png"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{tier_level}"));
        let v7 = 0x2::display::new_with_fields<0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::BadgeNFT<BETA_BADGE>>(&v2, v3, v5, arg2);
        0x2::display::update_version<0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::BadgeNFT<BETA_BADGE>>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::BadgeNFT<BETA_BADGE>>>(v7, 0x2::tx_context::sender(arg2));
        0x2996c9b4d6b9a634fa629af052fe05876e4963a26871ae4daec120f07712f83a::badge::return_publisher(arg1, v2, v1);
    }

    fun init(arg0: BETA_BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<BETA_BADGE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

