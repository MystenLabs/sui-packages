module 0x6201743e11653190f8a1dba5c7374f1dbc04e4c5ef6788762e0bd494d0156efa::aster_airdrop_on_stage_2 {
    struct ASTER_AIRDROP_ON_STAGE_2 has drop {
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

    fun init(arg0: ASTER_AIRDROP_ON_STAGE_2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ASTER_AIRDROP_ON_STAGE_2>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Aster Airdrop on Stage 2"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"41737465722069732061206e6578742d67656e65726174696f6e20646563656e7472616c697a65642065786368616e6765206f66666572696e6720626f74682050657270657475616c20616e642053706f742074726164696e672c2064657369676e65642061732061206f6e652d73746f70206f6e636861696e2076656e756520666f7220676c6f62616c2063727970746f20747261646572732e204974206665617475726573204d45562d667265652c206f6e652d636c69636b20657865637574696f6e20696e2053696d706c65204d6f64652e2050726f204d6f646520616464732032342f372073746f636b2070657270657475616c732c2048696464656e204f72646572732c20616e6420677269642074726164696e672c20617661696c61626c65206163726f737320424e4220436861696e2c20457468657265756d2c20536f6c616e612c20616e6420417262697472756d2e0a0a49747320756e697175652065646765206c69657320696e20746865206162696c69747920746f206f66666572206c69717569642d7374616b696e6720746f6b656e7320286173424e4229206f72207969656c642d67656e65726174696e6720737461626c65636f696e732028555344462920617320636f6c6c61746572616c2c20756e6c6f636b696e6720756e706172616c6c656c6564206361706974616c20656666696369656e63792e20506f776572656420627920417374657220436861696e2c206120686967682d706572666f726d616e636520616e6420707269766163792d666f6375736564204c312c20616e64206261636b656420627920595a69204c6162732c204173746572206973206275696c64696e672074686520667574757265206f6620446546693a20666173742c20666c657869626c652c20616e6420636f6d6d756e6974792d66697273742e0a0a417420746865206865617274206f6620746869732065636f73797374656d206973207468652024415354455220746f6b656e2c206120636f7265206173736574207468617420646563656e7472616c697a657320676f7665726e616e63652c206472697665732067726f7774682c20726577617264732070617274696369706174696f6e2c20616e6420737570706f727473206c6f6e672d7465726d207375737461696e6162696c6974792e0a0a5469636b65723a202441535445520a0a4d6178696d756d20737570706c793a20382c3030302c3030302c3030300a0a546f6b656e20666f726d61743a204245502d3230206f6e2042696e616e636520536d61727420436861696e0a0a546f6b656e20616464726573733a203078303030416533313445324132313732613033394232363337383831344332353237"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreiet4hihkhgyxxtyyiui6ergzomwqnoiaojmuw37uwf7sajtmzdqae"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 750, 0);
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

