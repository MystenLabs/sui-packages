module 0x8e08915671e2617f76f3b93945056b87e0a23086e9b065f64b522f2502aee46b::display_init {
    struct DISPLAY_INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISPLAY_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"7b6465736372697074696f6e7d20e28094207b6e6f74657d"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiscan.xyz/testnet/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Relics"));
        let v4 = 0x2::package::claim<DISPLAY_INIT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<0x8e08915671e2617f76f3b93945056b87e0a23086e9b065f64b522f2502aee46b::relics::Relic>(&v4, v0, v2, arg1);
        0x2::display::update_version<0x8e08915671e2617f76f3b93945056b87e0a23086e9b065f64b522f2502aee46b::relics::Relic>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x8e08915671e2617f76f3b93945056b87e0a23086e9b065f64b522f2502aee46b::relics::Relic>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

