module 0x768424c10376ae8a3ace8c2bcdea792d782860a6eab388ebd7422262cfdf5141::sui_ai_fun {
    struct SuiAiFun has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SUI_AI_FUN has drop {
        dummy_field: bool,
    }

    struct Share has store, key {
        id: 0x2::object::UID,
        current_mint: u64,
        max_mint: u64,
    }

    struct UserInfo has store {
        is_minted: bool,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
    }

    fun init(arg0: SUI_AI_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Launch and Co-Create Onchain AI Agents @SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiai.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiAiFun"));
        let v4 = 0x2::package::claim<SUI_AI_FUN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiAiFun>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiAiFun>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiAiFun>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Share{
            id           : 0x2::object::new(arg1),
            current_mint : 0,
            max_mint     : 1111,
        };
        0x2::transfer::share_object<Share>(v6);
    }

    public entry fun mint(arg0: &mut Share, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&arg1));
        let v2 = x"fc04db3fb918a7d3cfa796035397f858203195b298da8318cf171f93d4e7ce93";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v1), 0);
        let v3 = 0x1::string::utf8(b"SuiAiFun OG #");
        0x1::string::append(&mut v3, num_str(arg0.current_mint + 1));
        if (!0x2::dynamic_field::exists_with_type<address, UserInfo>(&arg0.id, v0)) {
            let v4 = UserInfo{
                is_minted : false,
                image_url : arg1,
                name      : v3,
            };
            0x2::dynamic_field::add<address, UserInfo>(&mut arg0.id, v0, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg0.id, v0);
        assert!(!v5.is_minted, 0);
        let v6 = SuiAiFun{
            id        : 0x2::object::new(arg3),
            name      : v3,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<SuiAiFun>(v6, v0);
        arg0.current_mint = arg0.current_mint + 1;
        v5.is_minted = true;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

