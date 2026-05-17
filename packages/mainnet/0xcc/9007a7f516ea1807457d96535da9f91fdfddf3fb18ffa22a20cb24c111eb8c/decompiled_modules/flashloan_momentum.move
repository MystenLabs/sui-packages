module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::flashloan_momentum {
    struct LLMeta has copy, drop {
        pool_id: 0x2::object::ID,
        repay_amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct LL<phantom T0> {
        receipt: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashLoanReceipt,
        meta: LLMeta,
    }

    public fun borrow_coin_type<T0>(arg0: &LL<T0>) : 0x1::ascii::String {
        arg0.meta.coin_type
    }

    public fun borrow_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T1>(arg0, arg1, 0, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        let v6 = LLMeta{
            pool_id      : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            repay_amount : v4,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        let v7 = LL<T0>{
            receipt : v3,
            meta    : v6,
        };
        (v0, v7)
    }

    public fun borrow_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_loan<T0, T1>(arg0, 0, arg1, arg2, arg3);
        let v3 = v2;
        0x2::balance::destroy_zero<T0>(v0);
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_receipt_debts(&v3);
        let v6 = LLMeta{
            pool_id      : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg0),
            repay_amount : v5,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        let v7 = LL<T1>{
            receipt : v3,
            meta    : v6,
        };
        (v1, v7)
    }

    public fun bx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        borrow_x<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun by<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        borrow_y<T0, T1>(arg0, arg1, arg2, arg3)
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

    public fun repay_amount<T0>(arg0: &LL<T0>) : u64 {
        arg0.meta.repay_amount
    }

    public fun repay_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let LL {
            receipt : v0,
            meta    : v1,
        } = arg2;
        let v2 = v1;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T1>(arg0, v0, 0x2::balance::split<T0>(&mut arg1, v2.repay_amount), 0x2::balance::zero<T1>(), arg3, arg4);
        arg1
    }

    public fun repay_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let LL {
            receipt : v0,
            meta    : v1,
        } = arg2;
        let v2 = v1;
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_loan<T0, T1>(arg0, v0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg1, v2.repay_amount), arg3, arg4);
        arg1
    }

    public fun rx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        repay_x<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun ry<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        repay_y<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

