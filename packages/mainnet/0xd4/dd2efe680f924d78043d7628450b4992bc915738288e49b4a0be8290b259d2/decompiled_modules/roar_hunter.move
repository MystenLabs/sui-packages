module 0xd4dd2efe680f924d78043d7628450b4992bc915738288e49b4a0be8290b259d2::roar_hunter {
    struct ROAR_HUNTER has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun mint_edition_nft(arg0: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &0x2::clock::Clock, arg3: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::kiosk::Kiosk, arg19: &0x2::kiosk::KioskOwnerCap, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg7, arg8, arg9, arg10, arg11, arg20);
        0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::mint_edition_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, v0, arg18, arg19, arg20);
    }

    public fun mint_nft(arg0: &0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg5, arg6, arg7, arg8, arg9, arg15);
        0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::mint_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, arg15);
    }

    public fun mint_order(arg0: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Manager, arg1: &0x2::clock::Clock, arg2: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Collection, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::mint_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun update_nft(arg0: &mut 0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        0x94229b0b27134ca6ca15bce88a66d00deaba7962b25b0c812a7555865ff4daa3::launchpad::update_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg8, arg9, arg1);
        v0.name = arg2;
        v0.description = arg3;
        v0.media_url = arg4;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg5, arg6);
    }

    fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        }
    }

    fun init(arg0: ROAR_HUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROAR_HUNTER>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Roar Hunter"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"54686520526f61722068756e7465722044414f2050617373206772616e74732066756c6c2061636365737320746f20526f617220426f6f737465722c2064657369676e656420746f20737570657263686172676520746f6b656e2070726f6a656374732e205468697320706173732070726f7669646573207369676e69666963616e7420676f7665726e616e636520706f7765722c20656e61626c696e6720796f7520746f2070726f706f736520616e6420766f7465206f6e20637269746963616c206368616e67657320746f2074686520526f617220426f742e20596f757220766f696365207368617065732074686520626f74e28099732066756e6374696f6e616c6974792c2073747261746567696320646972656374696f6e2c20616e6420706c6174666f726d2067726f7774682c20656e737572696e67207468652044414f2065766f6c76657320746f206d65657420636f6d6d756e697479206e656564732e204265796f6e6420676f7665726e616e63652c20746865207061737320656e7469746c657320796f7520746f20393025206f662074686520626f74e280997320726576656e75652c20646973747269627574656420746f204e465420686f6c646572732c206372656174696e672061206c7563726174697665207061737369766520696e636f6d652073747265616d2e20417320612070617373686f6c6465722c20796f75206a6f696e20616e20656c69746520636f6d6d756e6974792064726976696e67204465466920696e6e6f766174696f6e2c2077697468206578636c7573697665207065726b73206c696b65207072696f726974792061636365737320746f206d696e74696e67206576656e7473202877686974656c6973742920616e642066757475726520706c6174666f726d2066656174757265732e20686967682d706572666f726d616e636520626c6f636b636861696e2c2074686520526f61722048756e7465722044414f205061737320697320796f7572207469636b657420746f20696e666c75656e63652c206561726e696e67732c20616e6420696d7061637420696e2061207468726976696e6720446546692065636f73797374656d"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"walrus://Yt7nFUmPYhlmDt1szmGu6CZZe2ItN7UYEt4LmsVa1BY"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 250, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    // decompiled from Move bytecode v6
}

