module 0x3a7f0d061a0fd9ab77387a62218cfcff5ccef1c9b8fd15a11e6856fda9e36e27::atsukai_ {
    struct ATSUKAI_ has drop {
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

    fun init(arg0: ATSUKAI_, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ATSUKAI_>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"ATSUKAI "));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"415453554b414920e2809320504650204e46542050726f6a6563740a0a415453554b4149206973206120504650202850726f66696c65205069637475726529204e46542070726f6a6563742064657369676e656420746f2073686f776361736520756e69717565206469676974616c206964656e746974696573207468726f756768206120667573696f6e206f66206172742c2063756c747572652c20616e642073656c662d65787072657373696f6e2e204561636820706965636520696e2074686520636f6c6c656374696f6e207265666c6563747320612064697374696e637420706572736f6e616c6974792c20656e636f75726167696e6720757365727320746f2066696e642061206368617261637465722074686174207265736f6e617465732077697468207468656972206f776e206964656e7469747920696e20746865206469676974616c20776f726c642e0a0a4d6f7265207468616e206a75737420612076697375616c2070726f6a6563742c20415453554b41492061696d7320746f2063656c65627261746520696e646976696475616c697479207768696c65206578706c6f72696e67207468652067726f77696e6720706f74656e7469616c206f66205765623320636f6d6d756e697469657320616e642074686520636f6e63657074206f662074727565206469676974616c206f776e6572736869702e204974e28099732061207374657020746f77617264206275696c64696e6720612063726561746976652c20646563656e7472616c697a6564207370616365207768657265206964656e746974792c206172742c20616e6420746563686e6f6c6f677920696e746572736563742e0a0a5468697320696e697469616c204e4654206973206a7573742061207061737320e28094206120746561736572206f72206561726c792061636365737320746f6b656e20666f7220746865207570636f6d696e672066756c6c20504650204e46542064726f702e205468696e6b206f662069742061732061206669727374206c6f6f6b20696e746f2074686520776f726c64206f6620415453554b41492c20776865726520626967676572207468696e677320617265206f6e20746865207761792e0a0a417320616c776179732c2044594f522028446f20596f7572204f776e2052657365617263682920697320656e636f7572616765642e2054686973206973206e6f742066696e616e6369616c206164766963652e20415453554b4149206973206120637265617469766520696e6974696174697665206d65616e7420746f20696e737069726520637572696f736974792c2065787072657373696f6e2c20616e6420636f6d6d756e69747920656e676167656d656e742e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreien3mwlhcdj74p2dl3xi2sxp45mceb4xq5erpv7x6v4s7o3kpff6i"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 1000, 0);
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

