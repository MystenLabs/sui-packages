module 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::staking {
    struct StakingVault has key {
        id: 0x2::object::UID,
        version: u64,
        owners: 0x2::table::Table<0x2::object::ID, address>,
        reverse_owners: 0x2::table::Table<address, vector<0x2::object::ID>>,
        stork_kiosks: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        token_timestamps: 0x2::table::Table<0x2::object::ID, u64>,
        total_staked: u64,
    }

    struct STAKING_WITNESS has drop {
        dummy_field: bool,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: &mut StakingVault, arg1: &mut 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::ProtocolTreasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 7);
        let v0 = *0x2::table::borrow<address, vector<0x2::object::ID>>(&mut arg0.reverse_owners, 0x2::tx_context::sender(arg2));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(&mut arg0.id, v2);
            let v4 = calculate_stake(v3, *0x2::table::borrow<0x2::object::ID, u64>(&mut arg0.token_timestamps, v2), arg2);
            if (v4 > 0) {
                0x2::table::remove<0x2::object::ID, u64>(&mut arg0.token_timestamps, v2);
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.token_timestamps, v2, 0x2::tx_context::epoch_timestamp_ms(arg2));
                0x2::transfer::public_transfer<0x2::coin::Coin<0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::STORKTOKEN>>(0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::withdraw_staking(arg1, v4, arg2), *0x2::table::borrow<0x2::object::ID, address>(&arg0.owners, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::id(v3)));
            };
            v1 = v1 + 1;
        };
    }

    public fun calculate_stake(arg0: &0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        (0x2::tx_context::epoch_timestamp_ms(arg2) - arg1) / 86400000 * get_stake_per_day(arg0)
    }

    fun get_stake_per_day(arg0: &0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork) : u64 {
        2
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingVault{
            id               : 0x2::object::new(arg1),
            version          : 0,
            owners           : 0x2::table::new<0x2::object::ID, address>(arg1),
            reverse_owners   : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            stork_kiosks     : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            token_timestamps : 0x2::table::new<0x2::object::ID, u64>(arg1),
            total_staked     : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingVault>(v0);
    }

    public entry fun stake(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 7);
        stake_stork(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun stake_all(arg0: vector<0x2::object::ID>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
            stake_stork(*0x1::vector::borrow<0x2::object::ID>(&arg0, v0), arg1, arg2, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun stake_stork(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::kiosk::owner(arg1) == v0, 4);
        assert!(0x2::kiosk::has_item(arg1, arg0), 3);
        let (v1, v2) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::withdraw_nft_signed<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(arg1, arg0, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = STAKING_WITNESS{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::add_receipt<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, STAKING_WITNESS>(&mut v3, &v5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::confirm<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(v3, arg3);
        let v6 = 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::id(&v4);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(&mut arg2.id, v6, v4);
        if (0x2::table::contains<0x2::object::ID, address>(&mut arg2.owners, v6)) {
            0x2::table::remove<0x2::object::ID, address>(&mut arg2.owners, v6);
        };
        if (0x2::table::contains<0x2::object::ID, u64>(&mut arg2.token_timestamps, v6)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg2.token_timestamps, v6);
        };
        0x2::table::add<0x2::object::ID, address>(&mut arg2.owners, v6, v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg2.token_timestamps, v6, 0x2::tx_context::epoch_timestamp_ms(arg4));
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg2.stork_kiosks, v6, 0x2::object::uid_to_inner(0x2::kiosk::uid(arg1)));
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg2.reverse_owners, v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.reverse_owners, v0), v6);
        } else {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg2.reverse_owners, v0, 0x1::vector::singleton<0x2::object::ID>(v6));
        };
        arg2.total_staked = arg2.total_staked + 1;
    }

    public entry fun unstake(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &mut 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::ProtocolTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 7);
        unstake_stork(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_all(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut StakingVault, arg2: &mut 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::ProtocolTreasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 7);
        let v0 = *0x2::table::borrow<address, vector<0x2::object::ID>>(&mut arg1.reverse_owners, 0x2::tx_context::sender(arg3));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            unstake_stork(*0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg0, arg1, arg2, arg3);
            v1 = v1 + 1;
        };
    }

    fun unstake_stork(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &mut 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::ProtocolTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg2.owners, arg0) == v0, 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 4);
        assert!(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg2.stork_kiosks, arg0) == 0x2::object::uid_to_inner(0x2::kiosk::uid(arg1)), 6);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(&mut arg2.id, arg0);
        0x2::table::remove<0x2::object::ID, address>(&mut arg2.owners, arg0);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg2.stork_kiosks, arg0);
        let v2 = calculate_stake(&v1, 0x2::table::remove<0x2::object::ID, u64>(&mut arg2.token_timestamps, arg0), arg4);
        let v3 = v2;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(arg1, v1, arg4);
        arg2.total_staked = arg2.total_staked - 1;
        if (v2 > 0) {
            if (v2 >= 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::remaining_staking_supply(arg3)) {
                v3 = 0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::remaining_staking_supply(arg3);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::STORKTOKEN>>(0x1ae28fc0f48b0cc8090bd57384c4a7c09644c8d132af18ad9758f461102b9f32::storktoken::withdraw_staking(arg3, v3, arg4), v0);
        };
        let v4 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg2.reverse_owners, v0);
        if (0x1::vector::length<0x2::object::ID>(v4) == 1) {
            0x2::table::remove<address, vector<0x2::object::ID>>(&mut arg2.reverse_owners, v0);
        } else {
            let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(v4, &arg0);
            if (v5) {
                0x1::vector::remove<0x2::object::ID>(v4, v6);
            };
        };
    }

    // decompiled from Move bytecode v6
}

