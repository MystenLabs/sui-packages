module 0x4201286a2309f0b21aef14fcaede87c6181cd6dc7d4ce165a3f1ac6a24b2400c::liquidation {
    struct LiquidationExecuted has copy, drop {
        liquidator: address,
        position_owner: address,
        collateral_amount: u64,
        debt_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    struct LiquidationFailed has copy, drop {
        liquidator: address,
        position_owner: address,
        reason: u64,
        timestamp: u64,
    }

    struct LiquidationManager has key {
        id: 0x2::object::UID,
        liquidations_executed: u64,
        total_collateral_liquidated: u64,
        total_debt_repaid: u64,
        total_profit: u64,
        paused: bool,
        admin: address,
        authorized_liquidators: vector<address>,
        max_loan_amount: u64,
    }

    struct LiquidatablePosition has key {
        id: 0x2::object::UID,
        owner: address,
        collateral_amount: u64,
        debt_amount: u64,
        collateral_price: u64,
        debt_price: u64,
        last_update: u64,
    }

    public entry fun add_authorized_liquidator(arg0: &mut LiquidationManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        if (!0x1::vector::contains<address>(&arg0.authorized_liquidators, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_liquidators, arg1);
        };
    }

    public fun calculate_health_factor(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            return 999999999
        };
        arg0 * arg1 / 1000000 * 8000 / 10000 * 10000 / arg2 * arg3 / 1000000
    }

    public fun calculate_liquidation_amounts(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        let v0 = if (arg4 < arg2) {
            arg4
        } else {
            arg2
        };
        let v1 = v0 * arg3 / 1000000 * (10000 + 500) / 10000 * 1000000 / arg1;
        let v2 = if (v1 > arg0) {
            arg0
        } else {
            v1
        };
        (v0, v2, v2 * 500 / 10000)
    }

    public entry fun create_demo_position(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidatablePosition{
            id                : 0x2::object::new(arg5),
            owner             : arg0,
            collateral_amount : arg1,
            debt_amount       : arg2,
            collateral_price  : arg3,
            debt_price        : arg4,
            last_update       : 0,
        };
        0x2::transfer::share_object<LiquidatablePosition>(v0);
    }

    public entry fun create_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidationManager{
            id                          : 0x2::object::new(arg0),
            liquidations_executed       : 0,
            total_collateral_liquidated : 0,
            total_debt_repaid           : 0,
            total_profit                : 0,
            paused                      : false,
            admin                       : 0x2::tx_context::sender(arg0),
            authorized_liquidators      : 0x1::vector::empty<address>(),
            max_loan_amount             : 10000000000000,
        };
        0x2::transfer::share_object<LiquidationManager>(v0);
    }

    public entry fun execute_liquidation_demo<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T0>, arg2: &mut LiquidatablePosition, arg3: u64, arg4: &mut LiquidationManager, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.paused, 4);
        assert!(is_liquidatable(arg2.collateral_amount, arg2.collateral_price, arg2.debt_amount, arg2.debt_price), 2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let (v2, v3, _) = calculate_liquidation_amounts(arg2.collateral_amount, arg2.collateral_price, arg2.debt_amount, arg2.debt_price, arg3);
        assert!(v2 > 0 && v3 > 0, 6);
        assert!(v2 <= arg4.max_loan_amount, 7);
        let (v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, v2, arg7);
        let (_, _, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T1, T0>(arg1, v3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, v5, v6);
        0x2::coin::destroy_zero<T1>(0x2::coin::zero<T1>(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg6, v9, arg7), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg6, v0);
        arg2.collateral_amount = arg2.collateral_amount - v3;
        arg2.debt_amount = arg2.debt_amount - v2;
        arg2.last_update = v1;
        arg4.liquidations_executed = arg4.liquidations_executed + 1;
        arg4.total_collateral_liquidated = arg4.total_collateral_liquidated + v3;
        arg4.total_debt_repaid = arg4.total_debt_repaid + v2;
        let v10 = LiquidationExecuted{
            liquidator        : v0,
            position_owner    : arg2.owner,
            collateral_amount : v3,
            debt_amount       : v2,
            profit            : 0,
            timestamp         : v1,
        };
        0x2::event::emit<LiquidationExecuted>(v10);
    }

    public fun get_liquidations_executed(arg0: &LiquidationManager) : u64 {
        arg0.liquidations_executed
    }

    public fun get_position_health_factor(arg0: &LiquidatablePosition) : u64 {
        calculate_health_factor(arg0.collateral_amount, arg0.collateral_price, arg0.debt_amount, arg0.debt_price)
    }

    public fun get_total_collateral_liquidated(arg0: &LiquidationManager) : u64 {
        arg0.total_collateral_liquidated
    }

    public fun get_total_debt_repaid(arg0: &LiquidationManager) : u64 {
        arg0.total_debt_repaid
    }

    public fun get_total_profit(arg0: &LiquidationManager) : u64 {
        arg0.total_profit
    }

    public fun is_liquidatable(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        calculate_health_factor(arg0, arg1, arg2, arg3) < 10000
    }

    public entry fun set_pause_status(arg0: &mut LiquidationManager, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

