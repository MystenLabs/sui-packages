module 0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::bridge {
    struct NFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CollectionConfig has store {
        public_key: vector<u8>,
    }

    struct Config<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        mint_list: 0x2::table::Table<0x1::string::String, bool>,
        mint: 0x1::option::Option<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>,
        public_key: vector<u8>,
        freeze: bool,
    }

    struct BRIDGE has drop {
        dummy_field: bool,
    }

    struct SharedPublisher has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct ClaimNFTEvent<phantom T0> has copy, drop {
        sender: address,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        property_keys: vector<0x1::string::String>,
        property_values: vector<0x1::string::String>,
    }

    public entry fun claim_nft<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Config<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::Version::assert_version(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get_by_T<BRIDGE>(arg0));
        let v0 = b"";
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        let v2 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v2, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x1::string::String>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x1::string::String>>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.public_key, &v0), 1314);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.mint_list, arg2), 35);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.mint_list, arg2, true);
        let v3 = 0x1::vector::length<0x1::string::String>(&arg4);
        assert!(v3 == 0x1::vector::length<0x1::string::String>(&arg5), 1);
        let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v5 = 0;
        while (v5 < v3) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::vector::pop_back<0x1::string::String>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5));
            v5 = v5 + 1;
        };
        let v6 = NFT<T0>{
            id         : 0x2::object::new(arg7),
            name       : arg2,
            image_url  : arg3,
            properties : v4,
        };
        let v7 = ClaimNFTEvent<T0>{
            sender          : 0x2::tx_context::sender(arg7),
            name            : arg2,
            image_url       : arg3,
            property_keys   : arg4,
            property_values : arg5,
        };
        0x2::event::emit<ClaimNFTEvent<T0>>(v7);
        0x2::transfer::public_transfer<NFT<T0>>(v6, 0x2::tx_context::sender(arg7));
    }

    public entry fun create_bridge_config<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x2::package::Publisher, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::Version::assert_version(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get_by_T<BRIDGE>(arg0));
        0x2::package::published_package(arg1);
        let v0 = Config<T0>{
            id         : 0x2::object::new(arg3),
            owner      : 0x2::tx_context::sender(arg3),
            mint_list  : 0x2::table::new<0x1::string::String, bool>(arg3),
            mint       : 0x1::option::none<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>>(),
            public_key : arg2,
            freeze     : false,
        };
        0x2::transfer::share_object<Config<T0>>(v0);
    }

    public fun create_display<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<T0>, arg2: &SharedPublisher, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<NFT<T0>> {
        0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::Version::assert_version(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get_by_T<BRIDGE>(arg0));
        let v0 = 0x2::display::new<NFT<T0>>(&arg2.publisher, arg3);
        0x2::display::add<NFT<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<NFT<T0>>(&mut v0);
        v0
    }

    fun init(arg0: BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedPublisher{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<BRIDGE>(arg0, arg1),
        };
        0x2::transfer::public_share_object<SharedPublisher>(v0);
    }

    public entry fun modify_config_public_key<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut Config<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x923583a7ff785bd4466d1ad1537b2ee430f50e1d01906094f890e4736e3991e2::Version::assert_version(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get_by_T<BRIDGE>(arg0));
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 54);
        arg1.public_key = arg2;
    }

    // decompiled from Move bytecode v6
}

