module 0x7a2ec1fb2e3f5e11a8e1cc1ffbcd7efafe5590cdfa0ae3c6635efc3bd9713ca8::corn___bacon_sushi_nft___collection {
    struct CORN___BACON_SUSHI_NFT___COLLECTION has drop {
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

    fun init(arg0: CORN___BACON_SUSHI_NFT___COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CORN___BACON_SUSHI_NFT___COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(x"436f726e2026204261636f6e205375736869204e465420e2809420436f6c6c656374696f6e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4d61726b657420646f776e3f0a537573686920736d696c696e672e0a506f7274666f6c696f207265643f0a537573686920766962696e672e0a4c697175696469747920676f6e653f0a5375736869206772696c6c696e67206261636f6e2e0a496e206120776f726c6420776865726520747261646572732070616e69632c206368617274732063726173682c20616e642054776974746572206578706c6f646573e280a60a436f726e2026204261636f6e205375736869206a7573742073746179732064656c6963696f75736c792063616c6d2e0af09f8cbd20436f726e203d20676f6c64656e20647265616d730af09fa593204261636f6e203d2063726973707920726573696c69656e63650af09f8d9a2052696365203d20736f6c696420666f756e646174696f6e0af09fa5a62042726f63636f6c69203d206c6f79616c20677265656e20656e657267790a486520646f65736ee2809974206665617220746865206469702e0a4865206d6172696e6174657320696e2069742e0a54686973204e465420726570726573656e74733a0ae280a220537572766976696e672062656172206d61726b6574730ae280a2204c61756768696e6720617420766f6c6174696c6974790ae280a220486f6c64696e67207468726f756768206368616f730ae280a22053746179696e67206375746520756e6465722070726573737572650a5768696c65206f74686572732073637265616d20e2809c4974e2809973206f76657221e2809d0a53757368692077686973706572733a0ae2809c42726fe280a6207a6f6f6d206f75742ee2809d0a4e6f742066696e616e6369616c206164766963652e0a4a75737420656d6f74696f6e616c2073746162696c69747920696e2033442e0a4c696d697465642045646974696f6e20e2809420436f726e2026204261636f6e205375736869204e4654202d20436f6c6c656374696f6e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeihfvz3tvnp7yansn7knlu5rwnwlerdwdzh24q7unimlen57v6f2km"));
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

