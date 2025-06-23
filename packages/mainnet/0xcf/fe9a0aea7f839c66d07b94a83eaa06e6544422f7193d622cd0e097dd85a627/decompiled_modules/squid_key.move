module 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::squid_key {
    struct SQUID_KEY has drop {
        dummy_field: bool,
    }

    struct SquidKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : SquidKey {
        SquidKey{id: 0x2::object::new(arg0)}
    }

    fun init(arg0: SQUID_KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Squid Key"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lewd artifact of culture. H-scene unlocker. Makes your waifu go kyaaaa~"));
        0x1::vector::push_back<0x1::string::String>(v3, 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::values::get_image_url(0x1::string::utf8(b"/images/squid-key.webp")));
        0x1::vector::push_back<0x1::string::String>(v3, 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::values::display_creator_value());
        0x1::vector::push_back<0x1::string::String>(v3, 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::values::display_project_url());
        0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::base_asset::init_state<SQUID_KEY, SquidKey>(arg0, v0, v2, 0xcffe9a0aea7f839c66d07b94a83eaa06e6544422f7193d622cd0e097dd85a627::values::royalty_bps(), arg1);
    }

    // decompiled from Move bytecode v6
}

