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
        borrow_base<T0, T1>(arg0, arg1, arg2)
    }

    public fun borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = LLMeta{
            pool_id      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            repay_amount : arg1,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        let v3 = LL<T0>{
            receipt : v1,
            meta    : v2,
        };
        (0x2::coin::into_balance<T0>(v0), v3)
    }

    public fun borrow_coin_type<T0>(arg0: &LL<T0>) : 0x1::ascii::String {
        arg0.meta.coin_type
    }

    public fun borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = LLMeta{
            pool_id      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            repay_amount : arg1,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        let v3 = LL<T1>{
            receipt : v1,
            meta    : v2,
        };
        (0x2::coin::into_balance<T1>(v0), v3)
    }

    public fun bq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        borrow_quote<T0, T1>(arg0, arg1, arg2)
    }

    public fun meta<T0>(arg0: &LL<T0>) : &LLMeta {
        &arg0.meta
    }

    public fun meta_coin_type(arg0: &LLMeta) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun meta_pool_id(arg0: &LLMeta) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun meta_repay_amount(arg0: &LLMeta) : u64 {
        arg0.repay_amount
    }

    public fun pool_id<T0>(arg0: &LL<T0>) : 0x2::object::ID {
        arg0.meta.pool_id
    }

    public fun rb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        repay_base<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun repay_amount<T0>(arg0: &LL<T0>) : u64 {
        arg0.meta.repay_amount
    }

    public fun repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            receipt : v0,
            meta    : v1,
        } = arg2;
        let v2 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v2.repay_amount), arg3), v0);
        arg1
    }

    public fun repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            receipt : v0,
            meta    : v1,
        } = arg2;
        let v2 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v2.repay_amount), arg3), v0);
        arg1
    }

    public fun rq<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        repay_quote<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

