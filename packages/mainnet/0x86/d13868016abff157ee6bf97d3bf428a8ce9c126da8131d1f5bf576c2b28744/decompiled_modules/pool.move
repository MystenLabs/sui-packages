module 0x86d13868016abff157ee6bf97d3bf428a8ce9c126da8131d1f5bf576c2b28744::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<T0>,
        authorized: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct FlashLoanReceipt<phantom T0> {
        pool: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &v0), 2);
        let v1 = FlashLoanReceipt<T0>{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            amount : arg1,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg1), arg2), v1)
    }

    public fun authorize<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: address) {
        check<T0>(arg1, arg0);
        if (!0x2::vec_set::contains<address>(&arg0.authorized, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.authorized, arg2);
        };
    }

    public fun available<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun check<T0>(arg0: &AdminCap, arg1: &Pool<T0>) {
        assert!(arg0.pool == 0x2::object::id<Pool<T0>>(arg1), 2);
    }

    public fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id         : 0x2::object::new(arg0),
            funds      : 0x2::balance::zero<T0>(),
            authorized : 0x2::vec_set::empty<address>(),
        };
        let v1 = AdminCap{
            id   : 0x2::object::new(arg0),
            pool : 0x2::object::id<Pool<T0>>(&v0),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        check<T0>(arg1, arg0);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun repay<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let FlashLoanReceipt {
            pool   : v0,
            amount : v1,
        } = arg2;
        assert!(v0 == 0x2::object::id<Pool<T0>>(arg0), 7);
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 6);
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg3)));
        arg1
    }

    public fun revoke<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: address) {
        check<T0>(arg1, arg0);
        if (0x2::vec_set::contains<address>(&arg0.authorized, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.authorized, &arg2);
        };
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check<T0>(arg1, arg0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

