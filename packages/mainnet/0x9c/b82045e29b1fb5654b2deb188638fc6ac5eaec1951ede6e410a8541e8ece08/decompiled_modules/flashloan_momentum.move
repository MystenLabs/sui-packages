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
        abort 0
    }

    public fun borrow_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        abort 0
    }

    public fun borrow_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
        abort 0
    }

    public fun bx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, LL<T0>) {
        abort 0
    }

    public fun by<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, LL<T1>) {
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

    public fun repay_amount<T0>(arg0: &LL<T0>) : u64 {
        abort 0
    }

    public fun repay_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun repay_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abort 0
    }

    public fun rx<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: LL<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 0
    }

    public fun ry<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: LL<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

