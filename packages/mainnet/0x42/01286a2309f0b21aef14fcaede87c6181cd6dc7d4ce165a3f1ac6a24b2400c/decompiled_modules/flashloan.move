module 0x4201286a2309f0b21aef14fcaede87c6181cd6dc7d4ce165a3f1ac6a24b2400c::flashloan {
    struct FlashLoanExecuted has copy, drop {
        borrower: address,
        amount: u64,
        pool_id: address,
        fee_paid: u64,
        timestamp: u64,
    }

    struct ArbitrageExecuted has copy, drop {
        executor: address,
        path: vector<address>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    struct FlashLoanManager has key {
        id: 0x2::object::UID,
        loans_executed: u64,
        total_volume: u64,
        total_fees: u64,
        total_profit: u64,
        paused: bool,
        admin: address,
        max_loan_amount: u64,
        authorized_users: vector<address>,
    }

    struct ArbitragePath has drop, store {
        pools: vector<address>,
        is_base_to_quote: vector<bool>,
        min_profit_amount: u64,
    }

    public entry fun add_authorized_user(arg0: &mut FlashLoanManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        if (!0x1::vector::contains<address>(&arg0.authorized_users, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_users, arg1);
        };
    }

    public fun calculate_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 9 / 10000
    }

    public entry fun create_manager(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanManager{
            id               : 0x2::object::new(arg0),
            loans_executed   : 0,
            total_volume     : 0,
            total_fees       : 0,
            total_profit     : 0,
            paused           : false,
            admin            : 0x2::tx_context::sender(arg0),
            max_loan_amount  : 1000000000000,
            authorized_users : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<FlashLoanManager>(v0);
    }

    public entry fun execute_two_pool_arbitrage<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &mut FlashLoanManager, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg5.paused, 4);
        assert!(arg2 <= arg5.max_loan_amount, 7);
        let v0 = 0x2::tx_context::sender(arg8);
        if (arg4) {
            let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg2, arg8);
            let v3 = v1;
            let v4 = 0x2::coin::value<T0>(&v3);
            let (_, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, v4, arg6);
            let (v8, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, v3, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v7, arg8), v6 * (10000 - 500) / 10000, arg6, arg8);
            let v11 = v9;
            0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v10);
            0x2::coin::destroy_zero<T0>(v8);
            let (v12, _, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&v11), arg6);
            let (v15, v16, v17) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, v11, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v14, arg8), v12 * (10000 - 500) / 10000, arg6, arg8);
            let v18 = v15;
            0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v17);
            0x2::coin::destroy_zero<T1>(v16);
            let v19 = 0x2::coin::value<T0>(&v18);
            let v20 = calculate_flash_loan_fee(v4);
            let v21 = v4 + v20;
            assert!(v19 >= v21 + arg3, 6);
            let v22 = v19 - v21;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut v18, v21, arg8), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v18, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg7, v0);
            arg5.loans_executed = arg5.loans_executed + 1;
            arg5.total_volume = arg5.total_volume + v4;
            arg5.total_fees = arg5.total_fees + v20;
            arg5.total_profit = arg5.total_profit + v22;
            let v23 = 0x1::vector::empty<address>();
            let v24 = &mut v23;
            0x1::vector::push_back<address>(v24, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0));
            0x1::vector::push_back<address>(v24, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
            let v25 = ArbitrageExecuted{
                executor      : v0,
                path          : v23,
                input_amount  : v4,
                output_amount : v19,
                profit        : v22,
                timestamp     : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ArbitrageExecuted>(v25);
        } else {
            let (v26, v27) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg2, arg8);
            let v28 = v26;
            let v29 = 0x2::coin::value<T1>(&v28);
            let (v30, _, v32) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, v29, arg6);
            let (v33, v34, v35) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, v28, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v32, arg8), v30 * (10000 - 500) / 10000, arg6, arg8);
            let v36 = v33;
            0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v35);
            0x2::coin::destroy_zero<T1>(v34);
            let (_, v38, v39) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&v36), arg6);
            let (v40, v41, v42) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, v36, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v39, arg8), v38 * (10000 - 500) / 10000, arg6, arg8);
            let v43 = v41;
            0x2::coin::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg7, v42);
            0x2::coin::destroy_zero<T0>(v40);
            let v44 = 0x2::coin::value<T1>(&v43);
            let v45 = calculate_flash_loan_fee(v29);
            let v46 = v29 + v45;
            assert!(v44 >= v46 + arg3, 6);
            let v47 = v44 - v46;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut v43, v46, arg8), v27);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v43, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(arg7, v0);
            arg5.loans_executed = arg5.loans_executed + 1;
            arg5.total_volume = arg5.total_volume + v29;
            arg5.total_fees = arg5.total_fees + v45;
            arg5.total_profit = arg5.total_profit + v47;
            let v48 = 0x1::vector::empty<address>();
            let v49 = &mut v48;
            0x1::vector::push_back<address>(v49, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0));
            0x1::vector::push_back<address>(v49, 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
            let v50 = ArbitrageExecuted{
                executor      : v0,
                path          : v48,
                input_amount  : v29,
                output_amount : v44,
                profit        : v47,
                timestamp     : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ArbitrageExecuted>(v50);
        };
    }

    public fun flash_loan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut FlashLoanManager, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        assert!(!arg2.paused, 4);
        assert!(arg1 <= arg2.max_loan_amount, 7);
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg4);
        let v2 = FlashLoanExecuted{
            borrower  : 0x2::tx_context::sender(arg4),
            amount    : arg1,
            pool_id   : 0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            fee_paid  : calculate_flash_loan_fee(arg1),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FlashLoanExecuted>(v2);
        (v0, v1)
    }

    public fun get_loans_executed(arg0: &FlashLoanManager) : u64 {
        arg0.loans_executed
    }

    public fun get_total_fees(arg0: &FlashLoanManager) : u64 {
        arg0.total_fees
    }

    public fun get_total_profit(arg0: &FlashLoanManager) : u64 {
        arg0.total_profit
    }

    public fun get_total_volume(arg0: &FlashLoanManager) : u64 {
        arg0.total_volume
    }

    public fun is_paused(arg0: &FlashLoanManager) : bool {
        arg0.paused
    }

    public fun return_flash_loan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg3: &mut FlashLoanManager) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_max_loan_amount(arg0: &mut FlashLoanManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        arg0.max_loan_amount = arg1;
    }

    public entry fun set_pause_status(arg0: &mut FlashLoanManager, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

