module 0x1ceb46b85726e25d181978e23b10743a31c786311bf1fc86f0e6f21aceb86285::tradenly_gold_credit_nft {
    struct TRADENLY_GOLD_CREDIT_NFT has drop {
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

    fun init(arg0: TRADENLY_GOLD_CREDIT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TRADENLY_GOLD_CREDIT_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Tradenly Gold Credit NFT"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"476574206561726c792061636365737320746f2074686520667574757265206f662070726564696374697665206d61726b657473207769746820746865204d4c423a20416476616e6365204163636573732043726564697473205365726965732c20746865206f6666696369616c204e465420636f6c6c656374696f6e20706f776572696e6720746865206c61756e6368206f66204d6f6e65794c696e652042657420e28094206120706565722d746f2d706565722c206d756c74692d636861696e2070726564696374696f6e20616e642062657474696e6720706c6174666f726d2062792054726164656e6c792e2045616368204e4654206772616e747320626f6e757320706c6174666f726d206372656469747320616e64206578636c757369766520626574612061636365737320746f204d4c42206265666f7265207075626c69632072656c6561736520696e204a756c792e204372656469747320617265207573656420746f20706c61636520626574732c20637265617465206d61726b6574732c20616e64206561726e2066726f6d206f7574636f6d65732e204e465420686f6c646572732072656365697665203230e28093333525206578747261206372656469747320636f6d706172656420746f207374616e64617264207075726368617365732c20616e642062756c6b2062757965727320756e6c6f636b206576656e206d6f72652e205468657365204e4654732061726520796f7572206561726c79207374616b6520696e2061207574696c6974792d66697273742062657474696e6720706c6174666f726d2074686174207265776172647320696e73696768742c2061636375726163792c20616e6420636f6d6d756e6974792d64726976656e206465636973696f6e206d616b696e672e20436f6c6c6563742c20636f6d706574652c20616e642077696e206265666f7265207468652067616d65206576656e20626567696e732e202068747470733a2f2f782e636f6d2f6d6f6e65796c696e65623232333937"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"walrus://M1wMnhVEYP8glUgGR4siP4dNb3fWuEFhsT_9DJHneh0"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 100, 0);
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

