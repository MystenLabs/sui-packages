module 0x15ca459a0028b863c8e7c211d4e3dcc7882f973d400afa0191453c9db1c5d083::sui20 {
    struct Global has store, key {
        id: 0x2::object::UID,
        sui20tokens: 0x2::bag::Bag,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Sui20Data<phantom T0> has store {
        supply: u64,
        meta: Sui20Meta,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct Sui20Meta has store {
        tick: 0x1::string::String,
        max: u64,
        limit: u64,
        decimals: u8,
        fee: u64,
    }

    struct Sui20<phantom T0> has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        amount: u64,
    }

    public fun transfer<T0>(arg0: &mut Global, arg1: vector<Sui20<T0>>, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        assert!(arg3 > 0, 7);
        let v2 = 0;
        while (!0x1::vector::is_empty<Sui20<T0>>(&arg1)) {
            let Sui20 {
                id     : v3,
                tick   : _,
                amount : v5,
            } = 0x1::vector::pop_back<Sui20<T0>>(&mut arg1);
            0x2::object::delete(v3);
            v2 = v2 + v5;
        };
        assert!(v2 >= arg3, 6);
        0x1::vector::destroy_empty<Sui20<T0>>(arg1);
        if (arg4) {
            0x2::coin::mint_and_transfer<T0>(&mut v1.treasury_cap, arg3, arg2, arg5);
        } else {
            let v6 = Sui20<T0>{
                id     : 0x2::object::new(arg5),
                tick   : v1.meta.tick,
                amount : arg3,
            };
            0x2::transfer::public_transfer<Sui20<T0>>(v6, arg2);
        };
        let v7 = v2 - arg3;
        if (v7 > 0) {
            let v8 = Sui20<T0>{
                id     : 0x2::object::new(arg5),
                tick   : v1.meta.tick,
                amount : v7,
            };
            0x2::transfer::public_transfer<Sui20<T0>>(v8, 0x2::tx_context::sender(arg5));
        };
    }

    public fun deploy<T0>(arg0: &mut Global, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: 0x2::coin::TreasuryCap<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 1);
        let v1 = Sui20Meta{
            tick     : 0x1::string::utf8(arg1),
            max      : arg2,
            limit    : arg3,
            decimals : arg4,
            fee      : arg5,
        };
        let v2 = Sui20Data<T0>{
            supply       : 0,
            meta         : v1,
            treasury_cap : arg6,
        };
        0x2::bag::add<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0, v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id          : 0x2::object::new(arg0),
            sui20tokens : 0x2::bag::new(arg0),
            fee         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<Global>(v0);
    }

    public fun mint<T0>(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        assert!(arg1 <= v1.meta.limit, 3);
        assert!(v1.supply + arg1 <= v1.meta.max, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1.meta.fee, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v1.supply = v1.supply + arg1;
        let v2 = Sui20<T0>{
            id     : 0x2::object::new(arg3),
            tick   : v1.meta.tick,
            amount : arg1,
        };
        0x2::transfer::public_transfer<Sui20<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun unwrap<T0>(arg0: &mut Global, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.sui20tokens, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, Sui20Data<T0>>(&mut arg0.sui20tokens, v0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 7);
        0x2::coin::burn<T0>(&mut v1.treasury_cap, arg1);
        let v3 = Sui20<T0>{
            id     : 0x2::object::new(arg2),
            tick   : v1.meta.tick,
            amount : v2,
        };
        0x2::transfer::public_transfer<Sui20<T0>>(v3, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

