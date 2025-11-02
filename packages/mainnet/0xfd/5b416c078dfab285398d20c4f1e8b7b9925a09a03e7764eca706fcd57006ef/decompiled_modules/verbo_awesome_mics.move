module 0xfd5b416c078dfab285398d20c4f1e8b7b9925a09a03e7764eca706fcd57006ef::verbo_awesome_mics {
    struct VERBO_AWESOME_MICS has drop {
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

    fun init(arg0: VERBO_AWESOME_MICS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VERBO_AWESOME_MICS>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Verbo Awesome Mics"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"f09f8ea420566572626f20565242204d6963726f70686f6e657320e2809420506f776572206f6620566f6963652c2050726f6f66206f6620566973696f6e0a0a556e6c6561736820796f757220766f6963652e20416d706c69667920796f75722070726573656e63652e2054686520566572626f20565242204d6963726f70686f6e6573204e465420436f6c6c656374696f6e20726570726573656e74732074686520686561727462656174206f662074686520566572626f205265766f6c7574696f6e20e280942077686572652063726561746976697479206d656574732063727970746f2c20616e6420736f756e64206265636f6d657320706f7765722e0a0a4561636820565242204d6963726f70686f6e65204e4654206973206d6f7265207468616e206469676974616c2061727420e28094206974e280997320796f7572206761746577617920746f20696e666c75656e63652c207265636f676e6974696f6e2c20616e64207265776172647320696e736964652074686520566572626f2065636f73797374656d2e204576657279206d69632073796d626f6c697a65732065787072657373696f6e2c20636f6d6d756e69636174696f6e2c20616e6420636f6e6e656374696f6e20e280942074686520636f72652076616c7565732064726976696e6720566572626f2056524220746f20656d706f7765722063726561746f72732c20617274697374732c20616e6420647265616d65727320776f726c64776964652e0a0ae29c85205554494c495459202620524557415244530a4e4654205374616b696e6720496e746567726174696f6e20e28093205374616b6520796f757220566572626f204d6963726f70686f6e6520746f206561726e20757020746f2033303025207265776172647320696e2056524220746f6b656e732e0a4578636c75736976652041636365737320e2809320486f6c6465727320676574206561726c7920656e74727920746f20566572626f206576656e74732c20706172746e657273686970732c20616e64207370656369616c2061697264726f70732e0a0a50726f6f66206f662043726561746f7220e28093204f776e20796f757220766f69636520696e2074686520646563656e7472616c697a656420776f726c642e20596f7572204e46542063657274696669657320796f7572206964656e74697479206173206120566572626f20766973696f6e6172792e0af09f92a520546865204d65737361676520697320436c6561723a0a54686f73652077686f20737065616b207769746820566572626f206172652068656172642e0a54686f73652077686f20686f6c6420566572626f204d6963726f70686f6e6573206172652072656d656d62657265642e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreiciafbqqlkzchv2pap4xicgspfv466bi7twlyqb4upfktgcznt4ru"));
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

