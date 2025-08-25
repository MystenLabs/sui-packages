module 0x68e23b28b24eeb6b73bab38fcee088006efd6764f3b8b62381a8f42b3326cf08::og_dunnies_2nd_map_piece_raffle {
    struct OG_DUNNIES_2ND_MAP_PIECE_RAFFLE has drop {
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

    fun init(arg0: OG_DUNNIES_2ND_MAP_PIECE_RAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OG_DUNNIES_2ND_MAP_PIECE_RAFFLE>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"OG Dunnies 2nd Map piece Raffle"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"4368617074657220323a205468652043617665206f66204563686f657320616e64207468652053756e6b656e20466f726573740a0a5468652044756e6e6965732047616e6720636f6e74696e7565732074686569722071756573742c20646973636f766572696e6720746865207365636f6e6420535549204e465420667261676d656e7420696e20612068696464656e206368616d62657220646565702077697468696e206120636176652e204a757374206173204d69636b6579207265616368657320666f722069742c2074686520426c61636b2048617420506972617465204861636b6572207472696767657273206120636176652d696e2e204c756e6120757365732068657220736f6e61722064657669636520746f2066696e6420616e2065736361706520726f7574652c20616e6420746865207465616d20626172656c79206573636170657320776974682074686520667261676d656e7420696e2068616e642e204c756e61207761726e73207468617420746865204861636b65722069732067726f77696e67206d6f7265206465737065726174652c20616e64207468652067616e67207265616c697a65732074696d652069732072756e6e696e67206f75742e0a0a5468656972206a6f75726e6579207468656e2074616b6573207468656d20746f207468652053756e6b656e20466f726573742c207768657265204b697020616e64204c756e612068656c70207468656d206576616465206469676974616c2074726170732e204174207468652063656e7465722c20746865792066696e642074686520746869726420535549204e465420667261676d656e7420696e73696465206120686f6c6c6f7720747265652e20412064726f6e652073706f7473207468656d2c20627574204c756e61206861636b73206974207573696e6720612054726f6a616e20617070207772697474656e20696e204d6f7665206c616e67756167652c2073746f7070696e67206974206a75737420696e2074696d652e20576974682064616e67657220636c6f73696e6720696e2c207468652044756e6e69657320707265737320666f72776172642c2064657465726d696e656420616e6420756e73746f707061626c652e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafkreiflzoynrf3n4inj2p47gul3v3h75ritrb6qxbqqd25mupbbv4decq"));
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

