module 0xcaffb31b0e0de6d41e176f6d8d2a49e39cb4937d8f7edbb85a8148e689a2f5b::c4_era_pixels__mmorpg_heroes {
    struct C4_ERA_PIXELS__MMORPG_HEROES has drop {
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

    fun init(arg0: C4_ERA_PIXELS__MMORPG_HEROES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<C4_ERA_PIXELS__MMORPG_HEROES>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"C4 Era Pixels: MMORPG Heroes"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"52656c6976652074686520676f6c64656e20616765206f662068617264636f7265204d4d4f525047732e2043342045726120506978656c732069732061207472696275746520746f20746865206c6567656e6461727920657261206f6620323030312d323030372c207768657265206576657279206c6576656c20776173206120626174746c6520616e642065766572792064656174682061206865617274627265616b2e0a0a426f726e206f6e207468652053756920626c6f636b636861696e2c207468697320636f6c6c656374696f6e206272696e6773206261636b207468652069636f6e696320636c61737365732c207468652065706963207369656765732c20616e6420746865206e656f6e2d6c6974206e6f7374616c676961206f66206f757220796f757468207468726f756768206d65746963756c6f75736c79206372616674656420313a3120706978656c206172742e2046726f6d207468652072687974686d696320736f6e6773206f662074686520456c76656e20776f6f647320746f20746865206461726b20736861646f7773206f6620746865206368616f746963207a6f6e65732c20656163682070696563652069732061206d656d6f7279206f662074686520274368726f6e69636c6520342720676c6f727920646179732e0a0a4e6f206d6f7265205850206c6f73732c206a7573742070757265206f6e2d636861696e206c65676163792e205368617270656e20796f757220626c616465732c2063686172676520796f757220736f756c73686f74732c20616e6420636c61696d20796f75722073706f7420696e207468652068616c6c206f66206865726f65732e0a0a57656c636f6d6520746f20746865204572612e0a496e20746865206d656d6f7279206f66204c696f6e6e6120616e6420496e76696e6369626c6520416c6c79"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeibrdiqztfmeadcrs3uc4p2atniaemeen627yj2qcrqgokpbxk24ia"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 400, 0);
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

