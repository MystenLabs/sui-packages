module 0xe607559ce277d303581cdf82d63d45f23da69a9879617b5abc041afc0724b11d::legends_imortalized {
    struct LEGENDS_IMORTALIZED has drop {
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

    fun init(arg0: LEGENDS_IMORTALIZED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LEGENDS_IMORTALIZED>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Legends Imortalized"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"5374657020696e746f20657465726e6974792077697468204c6567656e647320496d6d6f7274616c697a65642c20612062726561746874616b696e67204e465420636f6c6c656374696f6e20746861742063617074757265732074686520646566696e696e6720696e7374616e7473206f6620706f702063756c747572652069636f6e732c20686973746f726963616c20746974616e732c2077617274696d65206865726f65732c20706f6c69746963616c20766973696f6e61726965732c20616e6420747261696c626c617a657273206163726f7373206576657279207265616c6d206f662068756d616e20616368696576656d656e742e2045616368206469676974616c206d6173746572706965636520667265657a657320612073696e67756c61722c20656c65637472696679696e67206d6f6d656e74207768656e2067726561746e6573732069676e697465642074686520776f726c642e2046726f6d2074686520726f6172206f66207468652063726f7764206173206120726f636b20676f6420736872656473207468652066696e616c2063686f7264206f6620616e20616e7468656d207468617420646566696e656420612067656e65726174696f6e2c20746f2074686520647573742063686f6b656420626174746c656669656c642077686572652061206c6f6e6520636f6d6d616e646572e2809973207265736f6c7665207475726e6564207468652074696465206f6620686973746f727920746f2074686520687573686564206368616d6265722077686572652061206c6561646572e280997320776f7264732072656472657720746865206d6170206f66206e6174696f6e7320746f207468652073696c7665722073637265656e20666c6173682077686572652061206865726fe28099732064656669616e636520626563616d65206c6567656e642e2054686573652061726520746865206672616d6573207468617420736861706564206f757220636f6c6c65637469766520736f756c2e2057686574686572206974e2809973207468652073776561742d6472656e6368656420747269756d7068206f6620616e20756e646572646f67206368616d70696f6e2c2074686520737465656c792067617a65206f662061206d6f6e6172636820666f7267696e6720616e20656d706972652c206f72207468652064656669616e74206772696e206f66206120706f702063756c747572652070726f766f636174657572206372617368696e67207468726f75676820626172726965727321205468657365204e46547320646f6ee2809974206a75737420646570696374206c6567656e64732e204d696e7420796f7572206d6f6d656e742e20436c61696d20796f7572206c6567656e642e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreibdongtvlkcwy35aebosyvzr7kaghw7taausbkmvwdh34sbqhoopm"));
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

