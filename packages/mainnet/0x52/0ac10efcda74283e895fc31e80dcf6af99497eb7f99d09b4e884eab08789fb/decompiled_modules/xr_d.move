module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::xr_d {
    struct Loan<phantom T0, phantom T1> {
        loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        owed: u64,
        rest: 0x2::balance::Balance<T0>,
    }

    struct LoanQuote<phantom T0, phantom T1> {
        loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        owed: u64,
        rest: 0x2::balance::Balance<T1>,
    }

    public fun db0<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<Loan<T0, T1>>) {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<Loan<T0, T1>>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ai(arg0), arg2);
        let v2 = v0;
        let v3 = Loan<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T0>(&v2),
            rest : 0x2::balance::zero<T0>(),
        };
        (0x2::coin::into_balance<T0>(v2), 0x1::option::some<Loan<T0, T1>>(v3))
    }

    public fun db1<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<LoanQuote<T0, T1>>) {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<LoanQuote<T0, T1>>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ai(arg0), arg2);
        let v2 = v0;
        let v3 = LoanQuote<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T1>(&v2),
            rest : 0x2::balance::zero<T1>(),
        };
        (0x2::coin::into_balance<T1>(v2), 0x1::option::some<LoanQuote<T0, T1>>(v3))
    }

    public fun df0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x1::option::Option<Loan<T0, T1>>) {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T1>(), 0x1::option::none<Loan<T0, T1>>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg1, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true), arg3);
        let v2 = v0;
        let (v3, v4) = sw0<T0, T1>(arg1, 0x2::coin::into_balance<T0>(v2), arg2, arg3);
        let v5 = Loan<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T0>(&v2),
            rest : v4,
        };
        (v3, 0x1::option::some<Loan<T0, T1>>(v5))
    }

    public fun df1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1::option::Option<LoanQuote<T0, T1>>) {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            return (0x2::balance::zero<T0>(), 0x1::option::none<LoanQuote<T0, T1>>())
        };
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg1, 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false), arg3);
        let v2 = v0;
        let (v3, v4) = sw1<T0, T1>(arg1, 0x2::coin::into_balance<T1>(v2), arg2, arg3);
        let v5 = LoanQuote<T0, T1>{
            loan : v1,
            owed : 0x2::coin::value<T1>(&v2),
            rest : v4,
        };
        (v3, 0x1::option::some<LoanQuote<T0, T1>>(v5))
    }

    public fun dg0<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<Loan<T0, T1>>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x1::option::destroy_none<Loan<T0, T1>>(arg2);
            return arg3
        };
        let Loan {
            loan : v0,
            owed : v1,
            rest : v2,
        } = 0x1::option::destroy_some<Loan<T0, T1>>(arg2);
        0x2::balance::join<T0>(&mut arg3, v2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T0>(&mut arg3, v1), arg4), v0);
        arg3
    }

    public fun dg1<T0, T1>(arg0: &0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<LoanQuote<T0, T1>>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x1::option::destroy_none<LoanQuote<T0, T1>>(arg2);
            return arg3
        };
        let LoanQuote {
            loan : v0,
            owed : v1,
            rest : v2,
        } = 0x1::option::destroy_some<LoanQuote<T0, T1>>(arg2);
        0x2::balance::join<T1>(&mut arg3, v2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::tk<T1>(&mut arg3, v1), arg4), v0);
        arg3
    }

    public fun ds0<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), true);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1) = sw0<T0, T1>(arg1, arg2, arg3, arg4);
        sweep<T0>(v1, arg4);
        v0
    }

    public fun ds1<T0, T1>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::bl(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), false);
        if (!0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ia(arg0)) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1) = sw1<T0, T1>(arg1, arg2, arg3, arg4);
        sweep<T1>(v1, arg4);
        v0
    }

    fun sw0<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (0x2::coin::into_balance<T1>(v1), 0x2::coin::into_balance<T0>(v0))
    }

    fun sw1<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg3), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0, arg2, arg3);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

