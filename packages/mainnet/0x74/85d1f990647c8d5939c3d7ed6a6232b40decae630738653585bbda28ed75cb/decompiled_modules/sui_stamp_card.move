module 0x7485d1f990647c8d5939c3d7ed6a6232b40decae630738653585bbda28ed75cb::sui_stamp_card {
    struct SUI_STAMP_CARD has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
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

    fun init(arg0: SUI_STAMP_CARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUI_STAMP_CARD>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"SUI Stamp Card"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"54686520537569205374616d70204361726420436f6c6c656374696f6e20697320612070726573746967696f757320736572696573206f66206469676974616c20636f6c6c65637469626c6573206d696e746564206f6e207468652053756920626c6f636b636861696e2c2063656c6562726174696e672074686520696e6e6f766174696f6e2c2073706565642c20616e64207363616c6162696c697479206f6620746865205375692065636f73797374656d2e204561636820537569205374616d702043617264206973206120756e69717565204e465420666561747572696e67206578636c757369766520617274776f726b207468617420656d626f646965732074686520737069726974206f6620537569e28099732063757474696e672d6564676520626c6f636b636861696e20746563686e6f6c6f67792e20576974682061206c696d6974656420737570706c79206f6620362c36363620756e69747320706572206974656d202865786365707420666f722073656c656374204f70656e2045646974696f6e206361726473292c20756e6d696e746564204e4654732077696c6c206265206275726e656420746f20656e73757265206578636c757369766974792e2044657369676e656420666f7220636f6c6c6563746f727320616e6420626c6f636b636861696e20656e7468757369617374732c207468697320636f6c6c656374696f6e206f66666572732061636365737320746f20612076696272616e742053756920636f6d6d756e69747920616e6420706f74656e7469616c2066757475726520726577617264732e204f776e2061207069656365206f662074686520537569206c656761637920776974682074686573652069636f6e6963206469676974616c207374616d70732e0a0d0d0ae280a2546f74616c20537570706c793a20362c36363620706572206974656d2028657863657074204f70656e2045646974696f6e2063617264732920200d0a0d0ae280a24275726e20506f6c6963793a20556e6d696e746564204e4654732077696c6c206265206275726e656420746f206d61696e7461696e206578636c757369766974790d0a0d"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"walrus://gxHgY6DZfgJ8qoisGyt9Qakh2kWTzhZuIOTwsFuI-OQ"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 50, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
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

    // decompiled from Move bytecode v6
}

