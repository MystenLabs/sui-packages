module 0xc5ddf1124892dca17c358ed0eb94b9218e762e2079106f54846b6762525d60c7::cybermythos {
    struct CYBERMYTHOS has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun create_nft_with_verification(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg6: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = Nft{
            id          : 0x2::object::new(arg6),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        };
        0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::set_verification_nft_id(arg5, 0x2::object::id<Nft>(&v0));
        v0
    }

    fun init(arg0: CYBERMYTHOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CYBERMYTHOS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"CyberMythos"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"496e206120756e69766572736520776865726520746563686e6f6c6f677920626c656e64732077697468206c6567656e642c2043796265724d7974686f7320697320626f726e20e2809420616e206570696320636f6c6c656374696f6e206f6620637962657270756e6b206865726f657320616e642076696c6c61696e7320726570726573656e74696e672074686520657465726e616c207374727567676c65206265747765656e206f7264657220616e64206368616f732e0a0a4561636820636861726163746572206973206d6f7265207468616e206a75737420616e20696c6c757374726174696f6e3a2074686579206172652061766174617273206f6620706f7765722c206c6976696e672073746f7269657320696e206120776f726c642072756c656420627920646174612c20656e657267792c20616e64206469676974616c20626174746c65732e2046726f6d20757262616e2077617272696f727320616e6420646174612068756e7465727320746f206d657263656e617269657320616e6420636f646520677561726469616e732c206561636820726172697479206c6576656c20e2809420436f6d6d6f6e2c20526172652c20457069632c204c6567656e646172792c20616e64204d797468696320e28094206d61726b73207468652065766f6c7574696f6e206f6620746865697220736b696c6c7320616e6420746865697220696e666c75656e6365206163726f737320746865206e6574776f726b2e0a0ae29a94efb88f20436f6d6d6f6e3a20746865206578706c6f72657273206f662074686520637962657270756e6b20776f726c642c2074686520666f756e646174696f6e206f6620746865206d7974682e0ae29ca820526172653a2063686172616374657273207769746820756e6971756520757067726164657320616e6420616476616e63656420746563686e6f6c6f67792e0af09f94a520457069633a20646f6d696e61746f7273206f6620746865206469676974616c20626174746c656669656c642077697468207370656369616c206162696c69746965732e0af09f9191204c6567656e646172793a206e6561722d696d6d6f7274616c20666967757265732c2066656172656420616e64207265737065637465642e0af09f8c8c204d79746869633a20756e6971756520656e7469746965732c207468652070696e6e61636c65206f6620706f77657220696e2043796265724d7974686f732e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeiexzuww4opnynwwaoh47o3nmavqdrfwbrxc3xbda2lqfgfq4x6m7e"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 500, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    public fun update_nft_with_verification(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::Verification, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x95e360f56458bf2862cd983b63aaa23e43997674eda99f28541cca1adfa44f50::launchpad::get_verification_nft_id(arg6) == arg0, 1);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, arg0);
        v0.name = arg1;
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

