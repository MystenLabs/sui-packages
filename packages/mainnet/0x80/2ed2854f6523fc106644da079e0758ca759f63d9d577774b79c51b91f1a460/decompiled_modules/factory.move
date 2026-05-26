module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::factory {
    struct BondFactory has key {
        id: 0x2::object::UID,
        admin: address,
        bond_creators: 0x2::vec_map::VecMap<address, CreatorInfo>,
        markets_by_name: 0x2::table::Table<vector<u8>, address>,
        paused: bool,
        emergency_paused: bool,
        total_markets_created: u64,
        total_treasuries_created: u64,
        max_markets_per_creator: u64,
        min_vesting_term: u64,
        max_vesting_term: u64,
    }

    struct CreatorInfo has copy, drop, store {
        enabled: bool,
        markets_created: u64,
        first_market_at: u64,
        last_market_at: u64,
    }

    struct FactoryInitializedEvent has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct TreasuryCreatedByFactoryEvent has copy, drop {
        treasury: address,
        payout_address: address,
        creator: address,
        timestamp: u64,
    }

    struct BondMarketCreatedEvent has copy, drop {
        market: address,
        name: vector<u8>,
        treasury: address,
        creator: address,
        timestamp: u64,
    }

    struct CreatorStatusChangedEvent has copy, drop {
        creator: address,
        enabled: bool,
        operator: address,
        timestamp: u64,
    }

    struct FactoryPausedEvent has copy, drop {
        paused: bool,
        emergency: bool,
        operator: address,
        timestamp: u64,
    }

    public fun create_bond_with_existing_treasury<T0, T1>(arg0: &mut BondFactory, arg1: &mut 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::Treasury<T0>, arg2: vector<u8>, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: address, arg17: vector<address>, arg18: u8, arg19: u8, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : address {
        assert!(!arg0.paused && !arg0.emergency_paused, 8);
        let v0 = 0x2::tx_context::sender(arg22);
        let v1 = 0x2::clock::timestamp_ms(arg21) / 1000;
        validate_and_update_creator(arg0, v0, v1);
        let v2 = if (arg14 == 0) {
            arg6
        } else {
            arg15 + arg6
        };
        let v3 = if (arg14 == 0) {
            0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::vesting_linear()
        } else {
            0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::curve::vesting_cliff_linear(arg15)
        };
        validate_market_name(&arg2);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.markets_by_name, arg2), 10);
        assert!(v2 >= arg0.min_vesting_term, 5);
        assert!(v2 <= arg0.max_vesting_term, 5);
        let v4 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond::create_market<T0, T1>(arg2, arg1, arg3, arg4, arg16, arg17, 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond::create_terms(arg5, v2, arg7, arg8, arg9, arg10, arg11), arg12, arg13, v3, arg18, arg19, arg20, arg21, arg22);
        0x2::table::add<vector<u8>, address>(&mut arg0.markets_by_name, arg2, v4);
        arg0.total_markets_created = arg0.total_markets_created + 1;
        let v5 = BondMarketCreatedEvent{
            market    : v4,
            name      : arg2,
            treasury  : 0x2::object::id_address<0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::Treasury<T0>>(arg1),
            creator   : v0,
            timestamp : v1,
        };
        0x2::event::emit<BondMarketCreatedEvent>(v5);
        v4
    }

    public fun create_treasury<T0>(arg0: &mut BondFactory, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : address {
        assert!(!arg0.paused && !arg0.emergency_paused, 8);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        validate_and_update_creator(arg0, v0, v1);
        let v2 = 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::treasury::create<T0>(arg1, arg2, arg5, arg3, arg4, arg6, arg7);
        arg0.total_treasuries_created = arg0.total_treasuries_created + 1;
        let v3 = TreasuryCreatedByFactoryEvent{
            treasury       : v2,
            payout_address : arg2,
            creator        : v0,
            timestamp      : v1,
        };
        0x2::event::emit<TreasuryCreatedByFactoryEvent>(v3);
        v2
    }

    public fun factory_stats(arg0: &BondFactory) : (u64, u64, bool, bool) {
        (arg0.total_markets_created, arg0.total_treasuries_created, arg0.paused, arg0.emergency_paused)
    }

    fun generate_treasury_name(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"Treasury of ";
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    public fun get_admin(arg0: &BondFactory) : address {
        arg0.admin
    }

    public fun grant_bond_creator_role(arg0: &mut BondFactory, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (0x2::vec_map::contains<address, CreatorInfo>(&arg0.bond_creators, &arg1)) {
            0x2::vec_map::get_mut<address, CreatorInfo>(&mut arg0.bond_creators, &arg1).enabled = true;
        } else {
            let v1 = CreatorInfo{
                enabled         : true,
                markets_created : 0,
                first_market_at : v0,
                last_market_at  : 0,
            };
            0x2::vec_map::insert<address, CreatorInfo>(&mut arg0.bond_creators, arg1, v1);
        };
        let v2 = CreatorStatusChangedEvent{
            creator   : arg1,
            enabled   : true,
            operator  : 0x2::tx_context::sender(arg3),
            timestamp : v0,
        };
        0x2::event::emit<CreatorStatusChangedEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_map::empty<address, CreatorInfo>();
        let v2 = CreatorInfo{
            enabled         : true,
            markets_created : 0,
            first_market_at : 0,
            last_market_at  : 0,
        };
        0x2::vec_map::insert<address, CreatorInfo>(&mut v1, v0, v2);
        let v3 = BondFactory{
            id                       : 0x2::object::new(arg0),
            admin                    : v0,
            bond_creators            : v1,
            markets_by_name          : 0x2::table::new<vector<u8>, address>(arg0),
            paused                   : false,
            emergency_paused         : false,
            total_markets_created    : 0,
            total_treasuries_created : 0,
            max_markets_per_creator  : 100,
            min_vesting_term         : 129600,
            max_vesting_term         : 31536000,
        };
        0x2::transfer::share_object<BondFactory>(v3);
    }

    public fun is_bond_creator(arg0: &BondFactory, arg1: address) : bool {
        0x2::vec_map::contains<address, CreatorInfo>(&arg0.bond_creators, &arg1) && 0x2::vec_map::get<address, CreatorInfo>(&arg0.bond_creators, &arg1).enabled
    }

    public fun market_by_name(arg0: &BondFactory, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.markets_by_name, arg1), 7);
        *0x2::table::borrow<vector<u8>, address>(&arg0.markets_by_name, arg1)
    }

    public fun pause_factory(arg0: &mut BondFactory, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        if (arg1) {
            arg0.emergency_paused = true;
        } else {
            arg0.paused = true;
        };
        let v0 = FactoryPausedEvent{
            paused    : true,
            emergency : arg1,
            operator  : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<FactoryPausedEvent>(v0);
    }

    public fun revoke_bond_creator_role(arg0: &mut BondFactory, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        if (0x2::vec_map::contains<address, CreatorInfo>(&arg0.bond_creators, &arg1)) {
            0x2::vec_map::get_mut<address, CreatorInfo>(&mut arg0.bond_creators, &arg1).enabled = false;
            let v0 = CreatorStatusChangedEvent{
                creator   : arg1,
                enabled   : false,
                operator  : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
            };
            0x2::event::emit<CreatorStatusChangedEvent>(v0);
        };
    }

    public fun unpause_factory(arg0: &mut BondFactory, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.paused = false;
        arg0.emergency_paused = false;
        let v0 = FactoryPausedEvent{
            paused    : false,
            emergency : false,
            operator  : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<FactoryPausedEvent>(v0);
    }

    fun validate_and_update_creator(arg0: &mut BondFactory, arg1: address, arg2: u64) {
        let v0 = arg1 == arg0.admin;
        assert!(v0 || 0x2::vec_map::contains<address, CreatorInfo>(&arg0.bond_creators, &arg1) && 0x2::vec_map::get<address, CreatorInfo>(&arg0.bond_creators, &arg1).enabled, 3);
        if (!v0) {
            let v1 = 0x2::vec_map::get_mut<address, CreatorInfo>(&mut arg0.bond_creators, &arg1);
            assert!(v1.markets_created < arg0.max_markets_per_creator, 5);
            v1.markets_created = v1.markets_created + 1;
            v1.last_market_at = arg2;
        };
    }

    fun validate_market_name(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 64, 9);
    }

    // decompiled from Move bytecode v7
}

