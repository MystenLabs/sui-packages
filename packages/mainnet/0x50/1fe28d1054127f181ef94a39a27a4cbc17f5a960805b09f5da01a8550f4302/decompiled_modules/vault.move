module 0x501fe28d1054127f181ef94a39a27a4cbc17f5a960805b09f5da01a8550f4302::vault {
    struct Master has store, key {
        id: 0x2::object::UID,
    }

    struct Matrix has key {
        id: 0x2::object::UID,
        vip: 0x2::table::Table<address, bool>,
        infos: 0x2::bag::Bag,
        f: u64,
    }

    struct R has copy, drop {
        a: u64,
        b: u64,
    }

    struct FlashLoan {
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &mut Matrix, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, FlashLoan) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.infos, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.infos, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 404);
        let v2 = FlashLoan{
            coin   : v0,
            amount : arg1,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2), arg1, v2)
    }

    public fun borrow_vec<T0>(arg0: &mut Matrix, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64, FlashLoan) {
        let (v0, v1, v2) = borrow<T0>(arg0, arg1, arg2);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v0);
        (v3, v1, v2)
    }

    public fun in_vip(arg0: &mut Matrix, arg1: address) {
        0x2::table::add<address, bool>(&mut arg0.vip, arg1, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Matrix{
            id    : 0x2::object::new(arg0),
            vip   : 0x2::table::new<address, bool>(arg0),
            infos : 0x2::bag::new(arg0),
            f     : 0,
        };
        let v1 = Master{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Master>(v1);
        0x2::transfer::share_object<Matrix>(v0);
    }

    public fun into<T0>(arg0: &mut Matrix, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.infos, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.infos, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.infos, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    fun is_vip(arg0: &Matrix, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.vip, arg1)
    }

    public fun out_vip(arg0: &mut Matrix, arg1: address) {
        0x2::table::remove<address, bool>(&mut arg0.vip, arg1);
    }

    public fun pay<T0>(arg0: &mut Matrix, arg1: FlashLoan, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_vip(arg0, 0x2::tx_context::sender(arg4)), 909);
        let FlashLoan {
            coin   : v0,
            amount : v1,
        } = arg1;
        assert!(v0 == 0x1::type_name::with_defining_ids<T0>(), 1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.infos, v0), 3);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > v1 && v2 - v1 >= arg3, 909);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.infos, v0), 0x2::coin::into_balance<T0>(arg2));
        let v3 = R{
            a : v1,
            b : v2,
        };
        0x2::event::emit<R>(v3);
    }

    public fun repay<T0>(arg0: &mut Matrix, arg1: FlashLoan, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_vip(arg0, 0x2::tx_context::sender(arg4)), 909);
        let FlashLoan {
            coin   : v0,
            amount : v1,
        } = arg1;
        assert!(v0 == 0x1::type_name::with_defining_ids<T0>(), 1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.infos, v0), 3);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.infos, v0);
        let v3 = 0x2::coin::value<T0>(&arg2);
        let v4 = v1 * (10000 + arg0.f) / 10000;
        assert!(v3 > v4 && v3 - v4 >= arg3, 909);
        0x2::balance::join<T0>(v2, 0x2::coin::into_balance<T0>(arg2));
        let v5 = R{
            a : v1,
            b : v3,
        };
        0x2::event::emit<R>(v5);
    }

    public fun take<T0>(arg0: &Master, arg1: &mut Matrix, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.infos, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.infos, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun update_fee_rate(arg0: &Master, arg1: &mut Matrix, arg2: u64) {
        arg1.f = arg2;
    }

    // decompiled from Move bytecode v6
}

