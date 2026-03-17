module 0xd703f480196ad9639b58a70877248fdaa2812e0437651bfb13dc97a22ccab221::r {
    struct AC has store, key {
        id: 0x2::object::UID,
    }

    struct V has key {
        id: 0x2::object::UID,
        s: 0x2::balance::Balance<0x2::sui::SUI>,
        l: u16,
    }

    struct R {
        a: u64,
        m: u64,
    }

    struct R2<phantom T0> {
        a: u64,
        m: u64,
    }

    public entry fun a5t(arg0: &mut V, arg1: &AC, arg2: u16) {
        arg0.l = arg2;
    }

    public fun b3c<T0>(arg0: &mut V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, R2<T0>) {
        assert!(arg1 > 0, 3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg1, 1);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2);
        let v2 = R2<T0>{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (v1, v2)
    }

    public fun b9x(arg0: &mut V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, R) {
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.s) >= arg1, 1);
        let v0 = R{
            a : arg1,
            m : arg1 * (10000 - (arg0.l as u64)) / 10000,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.s, arg1), arg2), v0)
    }

    public entry fun e4z(arg0: &mut V, arg1: &AC, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.s, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun g1q<T0>(arg0: &mut V, arg1: &AC, arg2: 0x2::coin::Coin<T0>) {
        let v0 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AC{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AC>(v0, 0x2::tx_context::sender(arg0));
        let v1 = V{
            id : 0x2::object::new(arg0),
            s  : 0x2::balance::zero<0x2::sui::SUI>(),
            l  : 100,
        };
        0x2::transfer::share_object<V>(v1);
    }

    fun tk<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    public entry fun u2r<T0>(arg0: &mut V, arg1: &AC, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, tk<T0>());
        assert!(0x2::balance::value<T0>(v0) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun w6j(arg0: &mut V, arg1: &AC, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.s) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.s, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun y4s<T0>(arg0: &mut V, arg1: 0x2::coin::Coin<T0>, arg2: R2<T0>) {
        let R2 {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 2);
        let v2 = tk<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun y7f(arg0: &mut V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: R) {
        let R {
            a : _,
            m : v1,
        } = arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.s, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v6
}

