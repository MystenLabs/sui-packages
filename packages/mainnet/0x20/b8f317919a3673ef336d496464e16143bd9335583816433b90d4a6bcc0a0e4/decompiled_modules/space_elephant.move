module 0x20b8f317919a3673ef336d496464e16143bd9335583816433b90d4a6bcc0a0e4::space_elephant {
    struct SPACE_ELEPHANT has drop {
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

    fun init(arg0: SPACE_ELEPHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SPACE_ELEPHANT>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Space Elephant"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"426f6f6b206f766572766965770a576861742069662068756d616e697479206469646ee2809974206c6f7365e280a62062757420776173207265706c616365643f0a0a496e20746865207965617220414420343030302c204561727468206e6f206c6f6e6765722062656c6f6e677320746f2068756d616e732e0a0a456c657068616e74732072756c652074686520706c616e657420e280942065766f6c7665642c20696e74656c6c6967656e742c20646f6d696e616e742e0a48756d616e733f205265647563656420746f2065786869626974732e204f627365727665642e20537475646965642e20466f72676f7474656e2e0a0a42757420736f6d657468696e672066617220776f72736520697320636f6d696e672e0a0a4120636f736d696320666f7263652c206f6c646572207468616e2067616c61786965732c20697320617070726f616368696e6720e280942068617276657374696e6720636f6e7363696f75736e65737320697473656c662e204e6f7420626f646965732e204e6f7420636976696c697a6174696f6e732e204d696e64732e0a0a4174207468652063656e746572206f6620697420616c6c3a0a0a416e20656c657068616e74207a6f6f6b65657065722077686f20626567696e7320746f207175657374696f6e207265616c6974790a412068756d616e20636f6e7363696f75736e657373207472617070656420696e736964652061206d6574616c207370686572650a4120636f736d696320736565642c20332062696c6c696f6e207965617273206f6c642c2077686973706572696e6720747275746873206e6f206d696e642073686f756c6420636f6d70726568656e640a546f6765746865722c207468657920756e636f76657220612074657272696679696e67207265616c697a6174696f6e3a0a0af09f918920436f6e7363696f75736e657373206d61792068617665206265656e2061206d697374616b652e0af09f9189204368616f73206d617920626520697473206f6e6c7920636f6e73657175656e63652e0a0a54686973206973206e6f74206a75737420612073746f72792061626f757420746865206675747572652e0a0a4974e28099732061626f75743a0a0a467265652077696c6c2076732064657465726d696e69736d0a414920616e6420706f73742d68756d616e2065766f6c7574696f6e0a54686520696c6c7573696f6e206f6620636f6e74726f6c0a416e6420746865206f6e65207468696e67206e6f2073797374656d2063616e20746f6c65726174653a0a412068756d616e20736179696e6720e2809c6e6f2ee2809d0a0af09f92a5205768792072656164657273206c6f7665207468697320626f6f6b3a0a0a44756e652d6c6576656c20776f726c646275696c64696e670a50"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreigreneuelpbquerhltqlmwbss6brbr2pypmnjqhpcwfdjc6wqjmzm"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 2000, 0);
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

