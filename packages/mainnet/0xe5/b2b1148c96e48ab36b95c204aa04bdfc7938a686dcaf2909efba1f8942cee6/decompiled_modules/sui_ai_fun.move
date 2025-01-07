module 0x39e86009ea6075b6ad156a96fcc96ede476b823436a2d08542799be0062a04f::sui_ai_fun {
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
        admin: address,
        current_mint: u64,
        version: u64,
        end_time: u64,
    }

    struct UserInfo has store {
        is_minted: bool,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct MintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun update_version(arg0: &mut Share, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0);
        arg0.version = 1;
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Suiai.fun launch and Co-Create Onchain AI Agents @SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiai.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiAiFun"));
        let v4 = 0x2::package::claim<SUI_AI_FUN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiAiFun>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiAiFun>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiAiFun>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Share{
            id           : 0x2::object::new(arg1),
            admin        : @0xf2db7827e4f6ea694f3f1526a7d61b802bdd8fddc176ac86a37db250703090fc,
            current_mint : 0,
            version      : 1,
            end_time     : 1738328400000,
        };
        0x2::transfer::share_object<Share>(v6);
    }

    public entry fun mint(arg0: &mut Share, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&arg1));
        let v2 = x"1d87fec5c564f4e983f999a77218839f9cdc4c8740a606f7879d24e8853aef33";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v1), 0);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 1);
        let v3 = 0x1::string::utf8(b"SuiAiFun Contributor #");
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
            id        : 0x2::object::new(arg4),
            name      : v3,
            image_url : arg1,
        };
        let v7 = MintedEvent{
            nft_id    : 0x2::object::id<SuiAiFun>(&v6),
            name      : v3,
            image_url : arg1,
        };
        0x2::event::emit<MintedEvent>(v7);
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

    public entry fun update_end_time(arg0: &mut Share, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.end_time = arg1;
    }

    // decompiled from Move bytecode v6
}

