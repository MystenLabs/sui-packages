module 0xb269a43ef22c49f0374bca4543810b16590241e81fa05a5e2147039e1c18d838::hub {
    struct Hub has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        versions: 0x2::vec_set::VecSet<u64>,
        paused: bool,
    }

    struct Slot has store {
        manager: 0x2::object::ID,
        trade: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        max_deep: u64,
    }

    public fun add_pool<T0, T1>(arg0: &mut Hub, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg3);
        let v1 = Slot{
            manager  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v0),
            trade    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg3),
            deposit  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg3),
            withdraw : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg3),
            max_deep : arg2,
        };
        0x2::dynamic_field::add<0x2::object::ID, Slot>(&mut arg0.id, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg1), v1);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v0);
    }

    public fun allow_version(arg0: &mut Hub, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 121);
        let v0 = 1;
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, v0);
        };
    }

    public fun ba<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &Hub, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0);
        check_leg(arg1, v0, arg2, arg7);
        let v1 = slot(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg6);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (_, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v9 = if (arg3) {
            let (_, _, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, v2, 0, arg5);
            funded(v1, arg2, v12)
        } else {
            false
        };
        let v13 = if (v9) {
            v2
        } else {
            div(v2, 1000000000 + mul(v3, 1250000000))
        };
        let v14 = v13 - v13 % v7;
        assert!(v14 >= v8, 110);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg2, &v1.deposit, 0x2::coin::from_balance<T0>(arg6, arg7), arg7);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg2, &v1.trade, arg7);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg2, &v16, 0, 0, v14, false, v9, arg5, arg7);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v17);
        assert!(v18 >= arg4, 100);
        leftover<T0>(v1, arg2, v15, arg7);
        0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg2, &v1.withdraw, v18, arg7))
    }

    public fun bb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &Hub, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg0);
        check_leg(arg1, v0, arg2, arg7);
        let v1 = slot(arg1, v0);
        let v2 = 0x2::balance::value<T1>(&arg6);
        let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = false;
        let v7 = 0;
        if (arg3) {
            let (v8, _, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v2, arg5);
            if (funded(v1, arg2, v10)) {
                v6 = true;
                v7 = v8;
            };
        };
        if (!v6) {
            let (v11, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, v2, arg5);
            v7 = v11;
        };
        let v14 = v7 - v7 % v4;
        assert!(v14 >= v5, 110);
        let v15 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg2, &v1.deposit, 0x2::coin::from_balance<T1>(arg6, arg7), arg7);
        let v16 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg2, &v1.trade, arg7);
        let v17 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg2, &v16, 0, 0, v14, true, v6, arg5, arg7);
        let v18 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v17);
        assert!(v18 >= arg4, 100);
        leftover<T1>(v1, arg2, v15, arg7);
        0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg2, &v1.withdraw, v18, arg7))
    }

    fun check_admin(arg0: &Hub, arg1: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 121);
    }

    fun check_leg(arg0: &Hub, arg1: 0x2::object::ID, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!arg0.paused, 122);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 120);
        check_manager(arg0, arg1, arg2);
    }

    fun check_manager(arg0: &Hub, arg1: 0x2::object::ID, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        assert!(0x2::dynamic_field::exists_with_type<0x2::object::ID, Slot>(&arg0.id, arg1), 125);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2) == slot(arg0, arg1).manager, 123);
    }

    fun check_version(arg0: &Hub) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 126);
    }

    public fun disallow_version(arg0: &mut Hub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg1);
        };
    }

    fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    fun funded(arg0: &Slot, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64) : bool {
        if (arg2 > 0) {
            if (arg2 <= arg0.max_deep) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1) >= arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hub{
            id        : 0x2::object::new(arg0),
            admin     : 0x2::tx_context::sender(arg0),
            operators : 0x2::vec_set::empty<address>(),
            versions  : 0x2::vec_set::singleton<u64>(1),
            paused    : false,
        };
        0x2::transfer::share_object<Hub>(v0);
    }

    fun leftover<T0>(arg0: &Slot, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        if (v0 > arg2) {
            0x2::coin::send_funds<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg1, &arg0.withdraw, v0 - arg2, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    public fun refill(arg0: &Hub, arg1: 0x2::object::ID, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_manager(arg0, arg1, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, &slot(arg0, arg1).deposit, arg3, arg4);
    }

    public fun remove_pool(arg0: &mut Hub, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        let Slot {
            manager  : _,
            trade    : v1,
            deposit  : v2,
            withdraw : v3,
            max_deep : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Slot>(&mut arg0.id, arg1);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap>(v1, arg0.admin);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap>(v2, arg0.admin);
        0x2::transfer::public_transfer<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap>(v3, arg0.admin);
    }

    public fun set_max_deep(arg0: &mut Hub, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg3);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, Slot>(&mut arg0.id, arg1).max_deep = arg2;
    }

    public fun set_operator(arg0: &mut Hub, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg3);
        if (arg2 != 0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
            if (arg2) {
                0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
            } else {
                0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
            };
        };
    }

    public fun set_paused(arg0: &mut Hub, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.paused = arg1;
    }

    fun slot(arg0: &Hub, arg1: 0x2::object::ID) : &Slot {
        0x2::dynamic_field::borrow<0x2::object::ID, Slot>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v7
}

