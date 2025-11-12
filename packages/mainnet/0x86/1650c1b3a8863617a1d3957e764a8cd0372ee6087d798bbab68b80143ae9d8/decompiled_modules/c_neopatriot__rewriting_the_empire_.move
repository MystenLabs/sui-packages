module 0x861650c1b3a8863617a1d3957e764a8cd0372ee6087d798bbab68b80143ae9d8::c_neopatriot__rewriting_the_empire_ {
    struct C_NEOPATRIOT__REWRITING_THE_EMPIRE_ has drop {
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

    fun init(arg0: C_NEOPATRIOT__REWRITING_THE_EMPIRE_, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<C_NEOPATRIOT__REWRITING_THE_EMPIRE_>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(x"e2809c4e656f50617472696f743a20526577726974696e672074686520456d70697265e2809d"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"e2809c4e656f50617472696f743a20526577726974696e672074686520456d70697265e2809d2069732061206469676974616c2072656177616b656e696e67206120636f6c6c6973696f6e206265747765656e206f6c6420676c6f727920616e6420746865206e656f6e2070756c7365206f6620746865206675747572652e2054686973204e4654207374616e64732061742074686520696e74657273656374696f6e206f6620726562656c6c696f6e2c2063756c747572652c20616e6420746563686e6f6c6f67792c20636170747572696e67207468652074656e73696f6e206265747765656e20747261646974696f6e20616e64207472616e73666f726d6174696f6e2e20496e2074686973207375727265616c2c2068797065722d73617475726174656420776f726c642c207468652066616d696c6961722069636f6e73206f66206e6174696f6e616c207072696465206d6565742074686520656c656374726963206772616666697469206f662061206e6577206469676974616c2067656e65726174696f6e2c207265696d6167696e696e6720776861742066726565646f6d2c206964656e746974792c20616e6420617274206d65616e20696e207468652057656233206572612e0a0a5468652070696563652063656e74657273206f6e20746865206d6f6e756d656e74616c2073696c686f7565747465206f66207468652057617368696e67746f6e204f62656c69736b20612073796d626f6c206f6620656e647572696e6720706f776572207472616e73666f726d656420696e746f2061206469676974616c2063616e766173206472656e6368656420696e20636f6c6f722c2067726166666974692c20616e64206d65616e696e672e20426568696e6420697420776176657320612077656174686572656420796574206d616a657374696320416d65726963616e20666c61672c20616e696d617465642062792073756e736574206c6967687420616e6420757262616e20656e657267792e204576657279207461672c2065766572792073796d626f6c2c20616e642065766572792073706c617368206f66207061696e742074656c6c7320612073746f7279206f6620746865207374727567676c65206265747765656e20636f6e666f726d69747920616e64206372656174696f6e2e205468697320697320416d65726963612072657772697474656e206279207468652068616e6473206f662069747320617274697374732c20636f646572732c20647265616d6572732c20616e6420726562656c73207468652061726368697465637473206f6620746865206d65746176657273652e0a0a"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeihtfsfuqc4cfrc6beee4qsresnjm4d6t2eqejpvgdcr7yhb65gzam"));
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

