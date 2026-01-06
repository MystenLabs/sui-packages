module 0x2623a9b53226cc8d1d611b864635214a2b45af50f35d4f481fd97cb5da408e2c::the_heavy_hippos__moo_deng_dynasty {
    struct THE_HEAVY_HIPPOS__MOO_DENG_DYNASTY has drop {
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

    fun init(arg0: THE_HEAVY_HIPPOS__MOO_DENG_DYNASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<THE_HEAVY_HIPPOS__MOO_DENG_DYNASTY>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"The Heavy Hippos: Moo Deng Dynasty"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4375746520466163652e2049726f6e20486964652e2053554920536f756c2e0a57656c636f6d6520746f2074686520486561767920486970706f733a204d6f6f2044656e672044796e617374792c20746865207072656d69657220636f6c6c656374696f6e206f662031353020686967682d666964656c6974792c20626174746c652d7265616479205079676d7920486970706f73206c6976696e6720657465726e616c6c79206f6e2074686520537569204e6574776f726b2e0a5765206c6f6f6b65642061742074686520766972616c2073656e736174696f6e206f66204d6f6f2044656e6720616e642061736b656420612073696d706c65207175657374696f6e3a20576861742069662074686973206368616f74696320656e657267792077617320776561706f6e697a65643f0a54686520726573756c742069732061206a6f75726e6579207468726f7567682074696d6520616e642073706163652e2057652068617665207265696d6167696e65642074686520696e7465726e6574e2809973206661766f7269746520616e696d616c206e6f7420617320612070617373697665207a6f6f2061747472616374696f6e2c20627574206173207468652074616e6b696573742077617272696f7220696e20686973746f72792e2046726f6d2074686520676f6c64656e2073616e6473206f6620416e6369656e7420456779707420746f20746865206e656f6e2d6472656e636865642073747265657473206f66206120437962657270756e6b206675747572652c2074686520486561767920486970706f7320617265206865726520746f20636f6e717565722074686520626c6f636b636861696e2e0a"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeigqfnms6nmhwhg44fgtkw2qontrp36okcmxrc6bnres4mmi5vfqcm"));
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

