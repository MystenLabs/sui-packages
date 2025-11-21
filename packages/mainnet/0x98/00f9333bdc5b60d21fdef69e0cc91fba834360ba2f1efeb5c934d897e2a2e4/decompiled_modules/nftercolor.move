module 0x9800f9333bdc5b60d21fdef69e0cc91fba834360ba2f1efeb5c934d897e2a2e4::nftercolor {
    struct NFTERCOLOR has drop {
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

    fun init(arg0: NFTERCOLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFTERCOLOR>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"NFTercolor"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"41206772656174206f70706f7274756e69747920746f206f776e204e465420776f726b73206f6620776f726c642d66616d6f7573207761746572636f6c6f722061727469737420596f756d6565205061726b0a0a5b4e4654204973737565645d0a3130206e6f726d616c204e4654730a2a417320616e20657863657074696f6e2c20736f6d6520776f726b73206973737565206f6e6c79206f6e65204e4654206174207468652072657175657374206f66207468652062757965722e0a0a41626f7574204172746973742c20596f75204d6565205061726b0ae296b62050726573656e740a0a507265736964656e74206f66204b6f726561205761746572636f6c6f72204173736f63696174696f6e2c0a507265736964656e74206f66204957532028496e7465726e6174696f6e616c205761746572636f6c6f72204173736f63696174696f6e290ae296b6204177617264730a4b6f726561205761746572636f6c6f7220436f6d7065746974696f6e204772616e64205072697a652c20457863656c6c656e6365205072697a652c205370656369616c2041776172642c206574632e0ae296b620536f6c6f2045786869626974696f6e0a2d33372074696d657320536f6c6f2065786869626974696f6e202853656f756c2c20427573616e2c2043616e61646120486f7765205374726565742047616c6c6572792c0a4368696e61205368616e686169204d6172742c4a656a752c204368656f6e676a752c204461656a656f6e2c204368756e676a752c205375776f6e2c2047696d686165290ae296b6205465616d2045786869626974696f6e0a50617274696369706174656420696e206d6f7265207468616e20393630207465616d2065786869626974696f6e730a49575320496e7669746174696f6e2045786869626974696f6e2028416c62616e69612c204b6f736f766f2c20486f6e67204b6f6e672c2051696e6764616f2c20566965746e616d2c205475726b65792c0a47617a69616e7465702c20496e6469612c20496e646f6e657369612c205368616e676861692c2042756c676172696129"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeihlvwfuwdqn2swsb2gjzocob5wgj3656nmad33qht33ir5sm5oygu"));
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

