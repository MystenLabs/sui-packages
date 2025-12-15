module 0x9f373ae82ac02783dd0d4f7269d0b957ebcb6f260fccbf91eb07818b89d2f72f::cat_club {
    struct CAT_CLUB has drop {
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

    fun init(arg0: CAT_CLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CAT_CLUB>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Cat Club"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4e79616e2043617420436c75620af09f8c88f09f90b1204e79616e2043617420436c756220e28093205768657265204b697474656e73204265636f6d65204469676974616c204c6567656e6473210a0a546865204e79616e2043617420436c756220697320616e206578636c757369766520636f6c6c656374696f6e206f66204e46547320696e7370697265642062792074686520706978656c20756e6976657273652c207261696e626f77732c20616e64207765622063756c747572652e2045616368204e79616e20697320756e697175652c2066756c6c206f6620706572736f6e616c6974792c207261726974792c20616e6420697473206f776e207374796c652e204372656174656420666f7220636f6c6c6563746f72732077686f2062656c6965766520696e2074686520706f776572206f66206469676974616c2061727420616e64207468652067726f777468206f662057656220332e0a0ae29ca820576879206a6f696e20746865204e79616e2043617420436c75623f0a0ae29c85203130302520756e69717565204e4654730ae29c852041637469766520616e642067726f77696e6720636f6d6d756e6974790ae29c852041636365737320746f206576656e74732c20726166666c65732c20616e64206675747572652061697264726f70730ae29c8520506f74656e7469616c20666f7220617070726563696174696f6e20776974682070726f6a65637420657870616e73696f6e0ae29c852046756e2c20636f6c6c65637469626c6520617274207769746820697473206f776e206964656e746974790a0af09f9a802054686973206973206e6f74206a75737420616e204e46542e204974277320796f75722070617373706f727420746f20612063726561746976652c20636f6c6f7266756c20636c75622066756c6c206f66206f70706f7274756e697469657320696e207468652063727970746f20776f726c642e0a0af09f928e204c696d69746564206f6666657220e280932053656375726520796f7572204e79616e206e6f77206265666f726520796f752062757920697421"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreicr2e6vdjfcri2rrt5vrwvf5myzmc6z6ql76z2ze2twl4r4wzo5xi"));
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

