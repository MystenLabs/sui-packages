module 0xe3d26a4f991be89e2182e2b25bccd19db0cfd7a2b23baf2773826795f5451bd7::warlordz_of_sui {
    struct WARLORDZ_OF_SUI has drop {
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

    fun init(arg0: WARLORDZ_OF_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WARLORDZ_OF_SUI>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Warlordz of Sui"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"e29a94efb88f205072657061726520666f7220626174746c652120596f752068617665206a75737420656e746572656420746865207761722d746f726e206f7263207265616c6d206f6e205375692e0a0a5761726c6f72647a206f66205375692028535549574152292069732061204c696d6974656420636f6c6c656374696f6e206f6620356b205072656d69756d204e46547320637261667465642066726f6d2068756e6472656473206f662068696768207175616c6974792c206469676974616c6c792068616e6420736b657463686564207472616974732e205468697320636f6c6c656374696f6e20776173207061696e7374616b696e676c792063726561746564206f7665722036206d6f6e746873206279207468652072656e6f776e656420636f6d696320617274697374206b6e6f776e20617320446173747269646f732e0a0a5768696c6520616c6c204f72637a206172652064697374696e637469766520262076616c7561626c652c205761726c6f726473206f662053756920666561747572657320646f7a656e73206f6620756e6971756520556c7472612052617265206c61796572732c206d6173736976656c7920656e68616e63696e672074686520636f6c6c6563746162696c697479206f66206365727461696e204e4654732e0a0ae298a0efb88f205468657365206172652043686965667461696e73206272656420746f20727574686c6573736c7920636f6e7175657220776f726c6473210a0ae2809c4f6e2074686569722073696465206d6f7265206d656e20617265207374616e64696e672e2e204f6e206f7572732c206d6f72652077696c6c20666967687421e2809d202d20416c6578616e646572205468652047726561740a0af09f94a5204275696c6420596f7572204c6567696f6e2c20437275736820596f757220466f65732c20436c61696d20596f757220476c6f727920496e20566963746f72792120e29a94efb88f"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeiawew3me24nzhkhhdklf32mgc6qikcsm6cshdzzvywkvaqrth7xoy"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 350, 0);
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

