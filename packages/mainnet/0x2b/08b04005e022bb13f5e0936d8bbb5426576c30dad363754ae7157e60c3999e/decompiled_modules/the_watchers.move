module 0x2b08b04005e022bb13f5e0936d8bbb5426576c30dad363754ae7157e60c3999e::the_watchers {
    struct THE_WATCHERS has drop {
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

    fun init(arg0: THE_WATCHERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<THE_WATCHERS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"The Watchers"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4c6f6e67206265666f72652068756d616e73206d656173757265642074696d652c2054686520576174636865727320647269667465642073696c656e746c79206265747765656e2064696d656e73696f6e732e20436c6f616b656420696e206c6976696e6720736861646f777320616e64206d61726b656420627920676c6f77696e67206372696d736f6e20657965732c207468657920617265206e6f742067686f7374732c206e6f7420616c69656e732c2062757420736f6d657468696e6720696e2d6265747765656e20656e746974696573207461736b65642077697468206f6273657276696e6720636976696c697a6174696f6e73206163726f73732067616c61786965732e0a0a54686579206e6576657220737065616b2c206275742074686579207265636f72642065766572797468696e672e204576657279206465636973696f6e2c20657665727920726973652c20657665727920636f6c6c617073652e20536f6d6520736179207468657920677569646520666174652c206f746865727320776869737065722074686579206f6e6c79206a756467652e204e6f206f6e65206b6e6f777320776861742068617070656e73207768656e206120576174636865722072656d6f7665732069747320686f6f64e280a62062656361757365206e6f206f6e6520686173206c6976656420746f2074656c6c207468652074616c652e0a0a4e6f772c20666f72207468652066697273742074696d652c207468652057617463686572732068617665207374657070656420696e746f20576562332e2045616368204e465420726570726573656e7473206120667261676d656e74206f6620746865697220657465726e616c206d697373696f6e2c206120756e6971756520656e746974792061737369676e656420746f206120686f6c6465722061732069747320e2809c63686f73656e206f627365727665722ee2809d204f776e696e67206f6e6520646f65736ee2809974206a757374206d65616e20617274206974206d65616e73206265696e67207365656e2062792077686174207365657320616c6c2e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeif2z6ulfs5gdqqhicsgfc7fyqapo2ofwfvmwc4eq2egx7unp6522q"));
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

