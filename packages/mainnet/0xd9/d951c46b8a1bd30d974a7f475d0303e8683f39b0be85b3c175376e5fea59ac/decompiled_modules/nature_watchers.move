module 0xd9d951c46b8a1bd30d974a7f475d0303e8683f39b0be85b3c175376e5fea59ac::nature_watchers {
    struct NATURE_WATCHERS has drop {
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

    fun init(arg0: NATURE_WATCHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NATURE_WATCHERS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Nature Watchers"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4e617475726520576174636865727320e280942031303020446179732c2031303020446f67730a416e2065766f6c76696e6720312f3120706978656c2d61727420636f6c6c656374696f6e2e0a0a4e617475726520576174636865727320697320612068616e646372616674656420736572696573206f6620312f3120706978656c2d61727420706f727472616974732063656c6562726174696e6720746865207175696574206d6f6d656e7473207765207368617265207769746820616e696d616c732e20456163682070696563652064657069637473206120646966666572656e7420646f67206272656564207374616e64696e6720696e20706561636566756c2070726f66696c652c2067617a696e67206f757420696e746f206e61747572652e20457665727920617274776f726b2069732066756c6c7920756e697175653a2061206e65772061746d6f7370686572652c206e6577206c69676874696e672c206e657720736561736f6e2c206e657720636f6c6f722070616c657474652c20616e642061206e657720696e746572707265746174696f6e206f66207468652073616d6520736572656e65206f7574646f6f72207363656e652e0a0a5468697320636f6c6c656374696f6e2069732072656c656173656420696e207265616c2074696d6520e28094206f6e6520646f67207065722064617920e2809420756e74696c20616c6c20313030206272656564732068617665206265656e20636f6d706c657465642e204e6f2074726169747320617265207265757365642e204e6f2064657369676e73207265706561742e204576657279207069656365207374616e64732061732061207472756520312f31207769746820697473206f776e206d6f6f6420616e64206964656e746974792e2046726f6d20706f6f646c657320746f20776f6c66686f756e64732c206875736b69657320746f20646163687368756e64732c20656163682072656c6561736520657870616e64732074686520776f726c6420616e642064656570656e732074686520656d6f74696f6e616c2073746f7279206f6620746865207365726965732e0a0a416674657220616c6c2031303020646f677320617265206d696e7465642c207468652070726f6a656374207472616e736974696f6e7320696e746f2053657269657320323a204e617475726520576174636865727320e2809420436174732c20626567696e6e696e672061206e6577206379636c652077697468206120667265736820706f73652c20656e7669726f6e6d656e742c20616e642061657374686574696320646972656374696f6e2e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeieumk2dgeyzzl3zcplfvtcwlzxmxibwa6m3wclik54hhylq3yaoam"));
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

