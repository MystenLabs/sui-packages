module 0xcfbdcf5d458f534eff193190b673c9941ed350ecd2f235c35f1c95271d483224::shieldpower_blue_edition__wave_1_ {
    struct SHIELDPOWER_BLUE_EDITION__WAVE_1_ has drop {
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

    fun init(arg0: SHIELDPOWER_BLUE_EDITION__WAVE_1_, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SHIELDPOWER_BLUE_EDITION__WAVE_1_>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"ShieldPower Blue Edition (Wave 1)"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"f09f929920536869656c64506f77657220426c75652045646974696f6e20e28094205761766520310a0a5468652066697273742073746570206f662061207472616e73706172656e742c20636f6d6d756e6974792d706f77657265642070726f6a656374206f6e20235355492e0a0af09f9ba1efb88f20312064657369676e20c2b720312c303030204e4654730af09f92a72031303025206f66207261697365642066756e647320e28692202453485057206c697175696469747920706f6f6c0af09f8e81205265776172643a2031302c30303020245348505720706572204e46540a0a45616368204e465420726570726573656e7473207265616c2070617274696369706174696f6e20696e2074686520536869656c64506f7765722065636f73797374656d2e0a0af09f948120526f79616c7479206665653a20332520287573656420666f72202453485057206275796261636b7320616e64206c697175696469747920737570706f7274290a0a5472616e73706172656e6379206973206f757220736869656c642e20e29aa1"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeia63t3gzykfzjlp4rckd3iywfla6qq3ltkexh32pqcz5ajou3mnsu"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 300, 0);
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

