module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::risk_management {
    struct InsuranceFund has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_deposits: u64,
        total_payouts: u64,
        coverage_ratio: u64,
        min_reserve_ratio: u64,
        admin: address,
        last_assessment: u64,
    }

    struct RiskPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        collateral_amount: u64,
        borrowed_amount: u64,
        risk_level: u8,
        liquidation_price: u64,
        last_update: u64,
        health_factor: u64,
    }

    struct RiskRegistry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_risk_exposure: u64,
        system_health_factor: u64,
        emergency_mode: bool,
        admin: address,
    }

    struct LiquidationData has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        liquidator: address,
        liquidated_amount: u64,
        penalty_amount: u64,
        timestamp: u64,
    }

    struct InsuranceFundDeposit has copy, drop {
        depositor: address,
        amount: u64,
        new_balance: u64,
    }

    struct InsuranceClaim has copy, drop {
        claimant: address,
        amount: u64,
        reason: vector<u8>,
        remaining_balance: u64,
    }

    struct RiskAssessment has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        risk_level: u8,
        health_factor: u64,
        liquidation_price: u64,
    }

    struct Liquidation has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        liquidator: address,
        liquidated_amount: u64,
        penalty_amount: u64,
        insurance_payout: u64,
    }

    struct EmergencyActivated has copy, drop {
        reason: vector<u8>,
        timestamp: u64,
        system_health: u64,
    }

    public entry fun activate_emergency_mode(arg0: &mut RiskRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 2);
        arg0.emergency_mode = true;
        let v0 = EmergencyActivated{
            reason        : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
            system_health : arg0.system_health_factor,
        };
        0x2::event::emit<EmergencyActivated>(v0);
    }

    fun assess_risk_level(arg0: u64) : u8 {
        if (arg0 >= 8000) {
            1
        } else if (arg0 >= 5000) {
            2
        } else if (arg0 >= 2000) {
            3
        } else {
            4
        }
    }

    fun calculate_health_factor(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 10000
        };
        arg0 * 10000 / arg1
    }

    fun calculate_liquidation_price(arg0: u64, arg1: u64) : u64 {
        arg1 * 12000 / 10000 * 1000000 / arg0
    }

    public entry fun create_risk_position(arg0: &mut RiskRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 * 10000 / arg2 >= 12000, 6);
        let v1 = calculate_health_factor(v0, arg2);
        let v2 = assess_risk_level(v1);
        let v3 = calculate_liquidation_price(v0, arg2);
        let v4 = RiskPosition{
            id                : 0x2::object::new(arg4),
            owner             : 0x2::tx_context::sender(arg4),
            collateral_amount : v0,
            borrowed_amount   : arg2,
            risk_level        : v2,
            liquidation_price : v3,
            last_update       : 0x2::clock::timestamp_ms(arg3),
            health_factor     : v1,
        };
        let v5 = 0x2::object::uid_to_inner(&v4.id);
        let v6 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.positions, v6)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.positions, v6, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.positions, v6), v5);
        arg0.total_risk_exposure = arg0.total_risk_exposure + arg2;
        let v7 = RiskAssessment{
            position_id       : v5,
            owner             : v6,
            risk_level        : v2,
            health_factor     : v1,
            liquidation_price : v3,
        };
        0x2::event::emit<RiskAssessment>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
        0x2::transfer::transfer<RiskPosition>(v4, v6);
    }

    public entry fun deposit_insurance(arg0: &mut InsuranceFund, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_deposits = arg0.total_deposits + v0;
        let v1 = InsuranceFundDeposit{
            depositor   : 0x2::tx_context::sender(arg2),
            amount      : v0,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<InsuranceFundDeposit>(v1);
    }

    public fun get_insurance_fund_balance(arg0: &InsuranceFund) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_position_info(arg0: &RiskPosition) : (address, u64, u64, u8, u64, u64) {
        (arg0.owner, arg0.collateral_amount, arg0.borrowed_amount, arg0.risk_level, arg0.liquidation_price, arg0.health_factor)
    }

    public fun get_system_health(arg0: &RiskRegistry) : (u64, bool) {
        (arg0.system_health_factor, arg0.emergency_mode)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InsuranceFund{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_deposits    : 0,
            total_payouts     : 0,
            coverage_ratio    : 10000,
            min_reserve_ratio : 2000,
            admin             : 0x2::tx_context::sender(arg0),
            last_assessment   : 0,
        };
        let v1 = RiskRegistry{
            id                   : 0x2::object::new(arg0),
            positions            : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_risk_exposure  : 0,
            system_health_factor : 10000,
            emergency_mode       : false,
            admin                : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<InsuranceFund>(v0);
        0x2::transfer::share_object<RiskRegistry>(v1);
    }

    public entry fun liquidate_position(arg0: &mut RiskRegistry, arg1: &mut InsuranceFund, arg2: RiskPosition, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.collateral_amount * arg3 / 1000000;
        assert!(calculate_health_factor(v0, arg2.borrowed_amount) < 10000, 4);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = arg2.borrowed_amount;
        let v3 = v2 * 1000 / 10000;
        let v4 = v2 + v3;
        let v5 = if (v0 < v4) {
            v4 - v0
        } else {
            0
        };
        let v6 = if (v5 > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v5, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v5, arg5), 0x2::tx_context::sender(arg5));
            arg1.total_payouts = arg1.total_payouts + v5;
            v5
        } else {
            0
        };
        arg0.total_risk_exposure = arg0.total_risk_exposure - v2;
        update_system_health(arg0);
        let v7 = Liquidation{
            position_id       : v1,
            owner             : arg2.owner,
            liquidator        : 0x2::tx_context::sender(arg5),
            liquidated_amount : v2,
            penalty_amount    : v3,
            insurance_payout  : v6,
        };
        0x2::event::emit<Liquidation>(v7);
        let v8 = LiquidationData{
            id                : 0x2::object::new(arg5),
            position_id       : v1,
            liquidator        : 0x2::tx_context::sender(arg5),
            liquidated_amount : v2,
            penalty_amount    : v3,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::transfer<LiquidationData>(v8, 0x2::tx_context::sender(arg5));
        let RiskPosition {
            id                : v9,
            owner             : _,
            collateral_amount : _,
            borrowed_amount   : _,
            risk_level        : _,
            liquidation_price : _,
            last_update       : _,
            health_factor     : _,
        } = arg2;
        0x2::object::delete(v9);
    }

    public entry fun update_risk_assessment(arg0: &mut RiskRegistry, arg1: &mut RiskPosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 2);
        let v0 = arg1.collateral_amount * arg2 / 1000000;
        let v1 = calculate_health_factor(v0, arg1.borrowed_amount);
        let v2 = assess_risk_level(v1);
        let v3 = calculate_liquidation_price(v0, arg1.borrowed_amount);
        arg1.health_factor = v1;
        arg1.risk_level = v2;
        arg1.liquidation_price = v3;
        arg1.last_update = 0x2::clock::timestamp_ms(arg3);
        update_system_health(arg0);
        let v4 = RiskAssessment{
            position_id       : 0x2::object::uid_to_inner(&arg1.id),
            owner             : arg1.owner,
            risk_level        : v2,
            health_factor     : v1,
            liquidation_price : v3,
        };
        0x2::event::emit<RiskAssessment>(v4);
    }

    fun update_system_health(arg0: &mut RiskRegistry) {
        if (arg0.total_risk_exposure == 0) {
            arg0.system_health_factor = 10000;
        } else {
            arg0.system_health_factor = 8500;
        };
    }

    // decompiled from Move bytecode v6
}

