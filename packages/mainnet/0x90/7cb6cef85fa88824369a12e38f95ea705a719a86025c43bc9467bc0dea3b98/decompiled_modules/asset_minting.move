module 0xf73c6b79515de40c6269a385221fc85a58fc612a18d371373993186bed75a53c::asset_minting {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionConfig<phantom T0> has key {
        id: 0x2::object::UID,
        signing_authority_required: bool,
        signing_authority_public_key: vector<u8>,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        mint_enable: bool,
        mint_payment_enable: bool,
        mint_payment: 0x1::option::Option<u64>,
        mint_payment_receiver: 0x1::option::Option<address>,
        mint_commission_enable: bool,
        mint_commission_payment: 0x1::option::Option<u64>,
        mint_commission_receiver: 0x1::option::Option<address>,
        collection_id: 0x2::object::ID,
        collection_transfer_policy: 0x2::object::ID,
        object_owner: 0x2::object::ID,
    }

    struct VersionConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        object_owner: 0x2::object::ID,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ASSET_MINTING has drop {
        dummy_field: bool,
    }

    struct NFTData has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
        collection_id: 0x2::object::ID,
    }

    struct CreateCollectionEvent has copy, drop {
        signing_authority_required: bool,
        signing_authority_public_key: vector<u8>,
        max_supply: 0x1::option::Option<u64>,
        mint_enable: bool,
        mint_payment_enable: bool,
        mint_payment: 0x1::option::Option<u64>,
        mint_payment_receiver: 0x1::option::Option<address>,
        mint_commission_enable: bool,
        mint_commission_payment: 0x1::option::Option<u64>,
        mint_commission_receiver: 0x1::option::Option<address>,
        collection_id: 0x2::object::ID,
        collection_config_id: 0x2::object::ID,
        transfer_policy_id: 0x2::object::ID,
        transfer_policy_cap_id: 0x2::object::ID,
    }

    struct UpdateCollectionConfigEvent has copy, drop {
        signing_authority_required: bool,
        signing_authority_public_key: vector<u8>,
        max_supply: 0x1::option::Option<u64>,
        mint_enable: bool,
        mint_payment_enable: bool,
        mint_payment: 0x1::option::Option<u64>,
        mint_payment_receiver: 0x1::option::Option<address>,
        mint_commission_enable: bool,
        mint_commission_payment: 0x1::option::Option<u64>,
        mint_commission_receiver: 0x1::option::Option<address>,
        updated_signing_authority_required: bool,
        updated_signing_authority_public_key: vector<u8>,
        updated_max_supply: 0x1::option::Option<u64>,
        updated_mint_enable: bool,
        updated_mint_payment_enable: bool,
        updated_mint_payment: 0x1::option::Option<u64>,
        updated_mint_payment_receiver: 0x1::option::Option<address>,
        updated_mint_commission_enable: bool,
        updated_mint_commission_payment: 0x1::option::Option<u64>,
        updated_mint_commission_receiver: 0x1::option::Option<address>,
        collection_id: 0x2::object::ID,
        collection_config_id: 0x2::object::ID,
    }

    struct MintNftEvent has copy, drop {
        nft_id: 0x2::object::ID,
        nft_owner: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        with_payment: bool,
        with_commission: bool,
        payment_coin_id: 0x1::option::Option<0x2::object::ID>,
        commission_payment_coin_id: 0x1::option::Option<0x2::object::ID>,
    }

    public entry fun create_collection<T0>(arg0: &VersionConfig, arg1: &0x2::package::Publisher, arg2: &AdminCap, arg3: bool, arg4: vector<u8>, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<address>, arg9: bool, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<address>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<address>, arg15: vector<u16>, arg16: 0x1::option::Option<u16>, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(arg0.object_owner == 0x2::object::id<AdminCap>(arg2), 1001);
        let v0 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<NFTData>(arg1);
        let v1 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create<NFTData>(v0, arg17);
        let (v2, v3) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<NFTData>(arg1, arg17);
        let v4 = v3;
        let v5 = v2;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<NFTData, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v0, &mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(arg12), 0x1::string::utf8(arg13)));
        if (!0x1::vector::is_empty<address>(&arg14)) {
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<NFTData, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v0, &mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&arg14)));
            if (!0x1::vector::is_empty<u16>(&arg15) && 0x1::option::is_some<u16>(&arg16)) {
                0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<NFTData>(v0, &mut v1, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(arg14, arg15), arg17), *0x1::option::borrow<u16>(&arg16), arg17);
                0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<NFTData>(&mut v5, &v4);
            };
        };
        if (arg6) {
            assert!(0x1::option::is_some<u64>(&arg7), 1013);
            assert!(0x1::option::is_some<address>(&arg8), 1014);
            if (arg9) {
                assert!(0x1::option::is_some<u64>(&arg10), 1015);
                assert!(0x1::option::is_some<address>(&arg11), 1016);
                assert!(*0x1::option::borrow<u64>(&arg7) > *0x1::option::borrow<u64>(&arg10), 1017);
            };
        };
        let v6 = CollectionConfig<T0>{
            id                           : 0x2::object::new(arg17),
            signing_authority_required   : arg3,
            signing_authority_public_key : arg4,
            max_supply                   : arg5,
            current_supply               : 0,
            mint_enable                  : true,
            mint_payment_enable          : arg6,
            mint_payment                 : arg7,
            mint_payment_receiver        : arg8,
            mint_commission_enable       : arg9,
            mint_commission_payment      : arg10,
            mint_commission_receiver     : arg11,
            collection_id                : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(&v1),
            collection_transfer_policy   : 0x2::object::id<0x2::transfer_policy::TransferPolicy<NFTData>>(&v5),
            object_owner                 : arg0.object_owner,
        };
        let v7 = CreateCollectionEvent{
            signing_authority_required   : arg3,
            signing_authority_public_key : arg4,
            max_supply                   : arg5,
            mint_enable                  : true,
            mint_payment_enable          : arg6,
            mint_payment                 : arg7,
            mint_payment_receiver        : arg8,
            mint_commission_enable       : arg9,
            mint_commission_payment      : arg10,
            mint_commission_receiver     : arg11,
            collection_id                : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(&v1),
            collection_config_id         : 0x2::object::id<CollectionConfig<T0>>(&v6),
            transfer_policy_id           : 0x2::object::id<0x2::transfer_policy::TransferPolicy<NFTData>>(&v5),
            transfer_policy_cap_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicyCap<NFTData>>(&v4),
        };
        0x2::event::emit<CreateCollectionEvent>(v7);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(v1);
        0x2::transfer::share_object<CollectionConfig<T0>>(v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFTData>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFTData>>(v4, 0x2::tx_context::sender(arg17));
    }

    fun init(arg0: ASSET_MINTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = VersionConfig{
            id           : 0x2::object::new(arg1),
            version      : 2,
            object_owner : 0x2::object::id<AdminCap>(&v0),
        };
        let v2 = 0x2::package::claim<ASSET_MINTING>(arg0, arg1);
        let v3 = 0x2::display::new<NFTData>(&v2, arg1);
        0x2::display::add<NFTData>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFTData>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFTData>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<NFTData>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<NFTData>(&mut v3, 0x1::string::utf8(b"collection_id"), 0x1::string::utf8(b"{collection_id}"));
        0x2::display::update_version<NFTData>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<NFTData>>(v3, 0x2::tx_context::sender(arg1));
        let (v4, v5) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::init_policy<NFTData>(&v2, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<NFTData, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>>(v4);
        0x2::transfer::public_share_object<VersionConfig>(v1);
    }

    public entry fun migrate_version_config(arg0: &mut VersionConfig, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.object_owner == 0x2::object::id<AdminCap>(arg1), 1001);
        assert!(arg0.version < 2, 1003);
        arg0.version = 2;
    }

    public entry fun mint_nft<T0>(arg0: &VersionConfig, arg1: &AdminCap, arg2: &mut CollectionConfig<T0>, arg3: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0x1::ascii::String>, arg9: vector<0x1::ascii::String>, arg10: 0x1::option::Option<vector<u8>>, arg11: 0x1::option::Option<vector<u8>>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(arg0.object_owner == 0x2::object::id<AdminCap>(arg1), 1001);
        assert!(arg2.object_owner == 0x2::object::id<AdminCap>(arg1), 1001);
        assert!(arg2.collection_id == 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg3), 1010);
        assert!(arg2.mint_enable, 1009);
        if (0x1::option::is_some<u64>(&arg2.max_supply)) {
            assert!(arg2.current_supply + 1 <= *0x1::option::borrow<u64>(&arg2.max_supply), 1011);
        };
        assert!(!arg2.mint_payment_enable, 1012);
        if (arg2.signing_authority_required) {
            assert!(0x1::option::is_some<vector<u8>>(&arg10), 1005);
            assert!(0x1::option::is_some<vector<u8>>(&arg11), 1006);
            let v0 = 0x1::option::extract<vector<u8>>(&mut arg10);
            let v1 = 0x2::hash::keccak256(&v0);
            let v2 = 0x1::option::extract<vector<u8>>(&mut arg11);
            assert!(0x2::ed25519::ed25519_verify(&v2, &arg2.signing_authority_public_key, &v1) == true, 1007);
        };
        let v3 = NFTData{
            id            : 0x2::object::new(arg12),
            name          : 0x1::string::utf8(arg5),
            description   : 0x1::string::utf8(arg6),
            url           : 0x2::url::new_unsafe_from_bytes(arg7),
            attributes    : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg8, arg9),
            collection_id : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg3),
        };
        arg2.current_supply = arg2.current_supply + 1;
        let v4 = MintNftEvent{
            nft_id                     : 0x2::object::id<NFTData>(&v3),
            nft_owner                  : 0x2::object::id_from_address(arg4),
            collection_id              : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg3),
            with_payment               : false,
            with_commission            : false,
            payment_coin_id            : 0x1::option::none<0x2::object::ID>(),
            commission_payment_coin_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<MintNftEvent>(v4);
        0x2::transfer::public_transfer<NFTData>(v3, arg4);
    }

    public entry fun mint_nft_with_payment<T0>(arg0: &VersionConfig, arg1: &mut CollectionConfig<T0>, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: 0x1::option::Option<vector<u8>>, arg10: 0x1::option::Option<vector<u8>>, arg11: &mut 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(arg1.collection_id == 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2), 1010);
        assert!(arg1.mint_enable, 1009);
        if (0x1::option::is_some<u64>(&arg1.max_supply)) {
            assert!(arg1.current_supply + 1 <= *0x1::option::borrow<u64>(&arg1.max_supply), 1011);
        };
        assert!(arg1.mint_payment_enable, 1012);
        if (arg1.signing_authority_required) {
            assert!(0x1::option::is_some<vector<u8>>(&arg9), 1005);
            assert!(0x1::option::is_some<vector<u8>>(&arg10), 1006);
            let v0 = 0x1::option::extract<vector<u8>>(&mut arg9);
            let v1 = 0x2::hash::keccak256(&v0);
            let v2 = 0x1::option::extract<vector<u8>>(&mut arg10);
            assert!(0x2::ed25519::ed25519_verify(&v2, &arg1.signing_authority_public_key, &v1) == true, 1007);
        };
        assert!(0x1::option::is_some<u64>(&arg1.mint_payment), 1013);
        assert!(0x1::option::is_some<address>(&arg1.mint_payment_receiver), 1014);
        assert!(0x2::coin::value<T0>(arg11) >= *0x1::option::borrow<u64>(&arg1.mint_payment), 1004);
        let v3 = 0x2::coin::split<T0>(arg11, *0x1::option::borrow<u64>(&arg1.mint_payment), arg12);
        let v4 = false;
        let v5 = 0x1::option::none<0x2::object::ID>();
        if (arg1.mint_commission_enable) {
            assert!(0x1::option::is_some<u64>(&arg1.mint_commission_payment), 1015);
            assert!(0x1::option::is_some<address>(&arg1.mint_commission_receiver), 1016);
            assert!(*0x1::option::borrow<u64>(&arg1.mint_commission_payment) < *0x1::option::borrow<u64>(&arg1.mint_payment), 1017);
            let v6 = 0x2::coin::split<T0>(&mut v3, *0x1::option::borrow<u64>(&arg1.mint_commission_payment), arg12);
            v4 = true;
            v5 = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&v6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, *0x1::option::borrow<address>(&arg1.mint_commission_receiver));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, *0x1::option::borrow<address>(&arg1.mint_payment_receiver));
        let v7 = NFTData{
            id            : 0x2::object::new(arg12),
            name          : 0x1::string::utf8(arg4),
            description   : 0x1::string::utf8(arg5),
            url           : 0x2::url::new_unsafe_from_bytes(arg6),
            attributes    : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg7, arg8),
            collection_id : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2),
        };
        arg1.current_supply = arg1.current_supply + 1;
        let v8 = MintNftEvent{
            nft_id                     : 0x2::object::id<NFTData>(&v7),
            nft_owner                  : 0x2::object::id_from_address(arg3),
            collection_id              : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2),
            with_payment               : true,
            with_commission            : v4,
            payment_coin_id            : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&v3)),
            commission_payment_coin_id : v5,
        };
        0x2::event::emit<MintNftEvent>(v8);
        0x2::transfer::public_transfer<NFTData>(v7, arg3);
    }

    public entry fun mint_nft_with_payment_v2<T0>(arg0: &VersionConfig, arg1: &mut CollectionConfig<T0>, arg2: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<0x1::ascii::String>, arg9: 0x1::option::Option<vector<u8>>, arg10: 0x1::option::Option<vector<u8>>, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(arg1.collection_id == 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2), 1010);
        assert!(arg1.mint_enable, 1009);
        if (0x1::option::is_some<u64>(&arg1.max_supply)) {
            assert!(arg1.current_supply + 1 <= *0x1::option::borrow<u64>(&arg1.max_supply), 1011);
        };
        assert!(arg1.mint_payment_enable, 1012);
        if (arg1.signing_authority_required) {
            assert!(0x1::option::is_some<vector<u8>>(&arg9), 1005);
            assert!(0x1::option::is_some<vector<u8>>(&arg10), 1006);
            let v0 = 0x1::option::extract<vector<u8>>(&mut arg9);
            let v1 = 0x2::hash::keccak256(&v0);
            let v2 = 0x1::option::extract<vector<u8>>(&mut arg10);
            assert!(0x2::ed25519::ed25519_verify(&v2, &arg1.signing_authority_public_key, &v1) == true, 1007);
        };
        assert!(0x1::option::is_some<u64>(&arg1.mint_payment), 1013);
        assert!(0x1::option::is_some<address>(&arg1.mint_payment_receiver), 1014);
        assert!(0x2::coin::value<T0>(&arg11) >= *0x1::option::borrow<u64>(&arg1.mint_payment), 1004);
        let v3 = 0x2::coin::split<T0>(&mut arg11, *0x1::option::borrow<u64>(&arg1.mint_payment), arg12);
        let v4 = false;
        let v5 = 0x1::option::none<0x2::object::ID>();
        if (arg1.mint_commission_enable) {
            assert!(0x1::option::is_some<u64>(&arg1.mint_commission_payment), 1015);
            assert!(0x1::option::is_some<address>(&arg1.mint_commission_receiver), 1016);
            assert!(*0x1::option::borrow<u64>(&arg1.mint_commission_payment) < *0x1::option::borrow<u64>(&arg1.mint_payment), 1017);
            let v6 = 0x2::coin::split<T0>(&mut v3, *0x1::option::borrow<u64>(&arg1.mint_commission_payment), arg12);
            v4 = true;
            v5 = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&v6));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, *0x1::option::borrow<address>(&arg1.mint_commission_receiver));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, *0x1::option::borrow<address>(&arg1.mint_payment_receiver));
        let v7 = NFTData{
            id            : 0x2::object::new(arg12),
            name          : 0x1::string::utf8(arg4),
            description   : 0x1::string::utf8(arg5),
            url           : 0x2::url::new_unsafe_from_bytes(arg6),
            attributes    : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(arg7, arg8),
            collection_id : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2),
        };
        arg1.current_supply = arg1.current_supply + 1;
        let v8 = MintNftEvent{
            nft_id                     : 0x2::object::id<NFTData>(&v7),
            nft_owner                  : 0x2::object::id_from_address(arg3),
            collection_id              : 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<NFTData>>(arg2),
            with_payment               : true,
            with_commission            : v4,
            payment_coin_id            : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<T0>>(&v3)),
            commission_payment_coin_id : v5,
        };
        0x2::event::emit<MintNftEvent>(v8);
        0x2::transfer::public_transfer<NFTData>(v7, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg11, 0x2::tx_context::sender(arg12));
    }

    public entry fun update_collection_config<T0>(arg0: &VersionConfig, arg1: &AdminCap, arg2: &mut CollectionConfig<T0>, arg3: bool, arg4: vector<u8>, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<address>, arg9: bool, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<address>, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 1002);
        assert!(arg0.object_owner == 0x2::object::id<AdminCap>(arg1), 1001);
        assert!(arg2.object_owner == 0x2::object::id<AdminCap>(arg1), 1001);
        let v0 = UpdateCollectionConfigEvent{
            signing_authority_required           : arg2.signing_authority_required,
            signing_authority_public_key         : arg2.signing_authority_public_key,
            max_supply                           : arg2.max_supply,
            mint_enable                          : arg2.mint_enable,
            mint_payment_enable                  : arg2.mint_payment_enable,
            mint_payment                         : arg2.mint_payment,
            mint_payment_receiver                : arg2.mint_payment_receiver,
            mint_commission_enable               : arg2.mint_commission_enable,
            mint_commission_payment              : arg2.mint_commission_payment,
            mint_commission_receiver             : arg2.mint_commission_receiver,
            updated_signing_authority_required   : arg3,
            updated_signing_authority_public_key : arg4,
            updated_max_supply                   : arg5,
            updated_mint_enable                  : arg12,
            updated_mint_payment_enable          : arg6,
            updated_mint_payment                 : arg7,
            updated_mint_payment_receiver        : arg8,
            updated_mint_commission_enable       : arg9,
            updated_mint_commission_payment      : arg10,
            updated_mint_commission_receiver     : arg11,
            collection_id                        : arg2.collection_id,
            collection_config_id                 : 0x2::object::id<CollectionConfig<T0>>(arg2),
        };
        if (arg6) {
            assert!(0x1::option::is_some<u64>(&arg7), 1013);
            assert!(0x1::option::is_some<address>(&arg8), 1014);
            if (arg9) {
                assert!(0x1::option::is_some<u64>(&arg10), 1015);
                assert!(0x1::option::is_some<address>(&arg11), 1016);
                assert!(*0x1::option::borrow<u64>(&arg7) > *0x1::option::borrow<u64>(&arg10), 1017);
            };
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(*0x1::option::borrow<u64>(&arg5) >= arg2.current_supply, 1018);
        };
        arg2.signing_authority_required = arg3;
        arg2.signing_authority_public_key = arg4;
        arg2.mint_enable = arg12;
        arg2.max_supply = arg5;
        arg2.mint_payment_enable = arg6;
        arg2.mint_payment = arg7;
        arg2.mint_payment_receiver = arg8;
        arg2.mint_commission_enable = arg9;
        arg2.mint_commission_payment = arg10;
        arg2.mint_commission_receiver = arg11;
        0x2::event::emit<UpdateCollectionConfigEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

