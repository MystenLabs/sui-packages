module 0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::staking {
    struct StakingVault has key {
        id: 0x2::object::UID,
        owners: 0x2::table::Table<0x2::object::ID, address>,
        token_timestamps: 0x2::table::Table<0x2::object::ID, u64>,
        total_staked: u64,
    }

    struct STAKING_WITNESS has drop {
        dummy_field: bool,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    public entry fun claim(arg0: 0x2::object::ID, arg1: &mut StakingVault, arg2: &mut 0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::ProtocolTreasury, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(&mut arg1.id, arg0);
        let v1 = calculate_stake(v0, *0x2::table::borrow<0x2::object::ID, u64>(&mut arg1.token_timestamps, arg0), arg3);
        assert!(v1 > 0, 5);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg1.token_timestamps, arg0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg1.token_timestamps, arg0, 0x2::tx_context::epoch_timestamp_ms(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::STORKTOKEN>>(0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::withdraw_staking(arg2, v1, arg3), *0x2::table::borrow<0x2::object::ID, address>(&arg1.owners, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::id(v0)));
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
            owners           : 0x2::table::new<0x2::object::ID, address>(arg1),
            token_timestamps : 0x2::table::new<0x2::object::ID, u64>(arg1),
            total_staked     : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakingVault>(v0);
    }

    public entry fun stake(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WITHDRAW_REQ>>, arg4: &mut 0x2::tx_context::TxContext) {
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
        0x2::table::add<0x2::object::ID, address>(&mut arg2.owners, v6, v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg2.token_timestamps, v6, 0x2::tx_context::epoch_timestamp_ms(arg4));
        arg2.total_staked = arg2.total_staked + 1;
    }

    public entry fun unstake(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut StakingVault, arg3: &mut 0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::ProtocolTreasury, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(*0x2::table::borrow<0x2::object::ID, address>(&arg2.owners, arg0) == v0, 4);
        assert!(0x2::kiosk::owner(arg1) == v0, 4);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(&mut arg2.id, arg0);
        let v2 = calculate_stake(&v1, *0x2::table::borrow<0x2::object::ID, u64>(&mut arg2.token_timestamps, arg0), arg4);
        let v3 = v2;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<0x5f1fa51a6d5c52df7dfe0ff7efaab7cc769d81e51cf208a424e455575aa1ed7a::stork::Stork>(arg1, v1, arg4);
        arg2.total_staked = arg2.total_staked - 1;
        if (v2 > 0) {
            if (v2 >= 0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::remaining_staking_supply(arg3)) {
                v3 = 0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::remaining_staking_supply(arg3);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::STORKTOKEN>>(0x2104affc569e2f19776c5b55306d010b05a69ea5a470f59ef669d7b9991da7b1::storktoken::withdraw_staking(arg3, v3, arg4), v0);
        };
    }

    // decompiled from Move bytecode v6
}

