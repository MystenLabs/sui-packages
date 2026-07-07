module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::flashloan_deepbook {
    struct LLMeta has copy, drop {
        pool_id: 0x2::object::ID,
        repay_amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct LL<phantom T0> {
        receipt: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        meta: LLMeta,
    }

    public fun bb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        abort 0
    }

    public fun borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        abort 0
    }

    public fun borrow_coin_type<T0>(arg0: &LL<T0>) : 0x1::ascii::String {
        abort 0
    }

    public fun borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        abort 0
    }

    public fun bq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        abort 0
    }

    public fun meta<T0>(arg0: &LL<T0>) : &LLMeta {
        abort 0
    }

    public fun meta_coin_type(arg0: &LLMeta) : 0x1::ascii::String {
        abort 0
    }

    public fun meta_pool_id(arg0: &LLMeta) : 0x2::object::ID {
        abort 0
    }

    public fun meta_repay_amount(arg0: &LLMeta) : u64 {
        abort 0
    }

    public fun pool_id<T0>(arg0: &LL<T0>) : 0x2::object::ID {
        abort 0
    }

    public fun rb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun repay_amount<T0>(arg0: &LL<T0>) : u64 {
        abort 0
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abort 0
    }

    public fun rq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

