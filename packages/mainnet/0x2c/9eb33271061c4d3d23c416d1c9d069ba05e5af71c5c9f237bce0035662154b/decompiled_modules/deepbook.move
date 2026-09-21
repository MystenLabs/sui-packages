module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::deepbook {
    fun addr<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : address {
        0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0)
    }

    public fun flash_borrow_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>> {
        if (!0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::armed(arg0)) {
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T0>(arg0, 0x2::balance::zero<T0>());
            return 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>()
        };
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, v0, arg2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v2, v0)
    }

    public fun flash_borrow_quote<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>> {
        if (!0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::armed(arg0)) {
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T1>(arg0, 0x2::balance::zero<T1>());
            return 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::none<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>()
        };
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, v0, arg2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T1>(arg0, 0x2::coin::into_balance<T1>(v1));
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(v2, v0)
    }

    public fun flash_repay_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&arg2)) {
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::close<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
            return
        };
        let (v0, v1) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
        let v2 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T0>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1), arg3), v0);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T0>(arg0, v2);
    }

    public fun flash_repay_quote<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::is_some<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(&arg2)) {
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::close<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
            return
        };
        let (v0, v1) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>(arg2);
        let v2 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T1>(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v1), arg3), v0);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T1>(arg0, v2);
    }

    public fun peek_buy_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, 0, arg2, arg1);
        v0
    }

    public fun peek_sell_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (_, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out_input_fee<T0, T1>(arg0, arg2, 0, arg1);
        v1
    }

    public fun quote_buy_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::record_quote(arg0, peek_buy_base<T0, T1>(arg1, arg2, arg3));
    }

    public fun quote_sell_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::record_quote(arg0, peek_sell_base<T0, T1>(arg1, arg2, arg3));
    }

    public fun r_buy_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T1>(arg0, arg3);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, 0x2::balance::zero<T0>(), addr<T0, T1>(arg1));
            return
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v0, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg2, arg4);
        let v4 = v2;
        assert!(0x2::coin::value<T1>(&v4) == 0, 100);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg3, 0x2::coin::into_balance<T0>(v1), addr<T0, T1>(arg1));
    }

    public fun r_sell_base<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, 0x2::balance::zero<T1>(), addr<T0, T1>(arg1));
            return
        };
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), 0, arg2, arg4);
        let v4 = v1;
        assert!(0x2::coin::value<T0>(&v4) == 0, 100);
        0x2::coin::destroy_zero<T0>(v4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg3, 0x2::coin::into_balance<T1>(v2), addr<T0, T1>(arg1));
    }

    // decompiled from Move bytecode v7
}

