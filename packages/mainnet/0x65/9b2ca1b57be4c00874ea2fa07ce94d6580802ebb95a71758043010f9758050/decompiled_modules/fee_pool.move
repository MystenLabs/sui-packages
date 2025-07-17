module 0x659b2ca1b57be4c00874ea2fa07ce94d6580802ebb95a71758043010f9758050::fee_pool {
    struct FeeDepositEvent<phantom T0> has copy, drop {
        sender: address,
        amount: u64,
    }

    struct FEE_POOL has drop {
        dummy_field: bool,
    }

    struct FeePool has store, key {
        id: 0x2::object::UID,
        pool: 0x2::bag::Bag,
    }

    public fun deposit<T0>(arg0: &mut FeePool, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.pool, v0)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.pool, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.pool, v0), arg1);
        let v1 = FeeDepositEvent<T0>{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<FeeDepositEvent<T0>>(v1);
    }

    fun init(arg0: FEE_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeePool{
            id   : 0x2::object::new(arg1),
            pool : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<FeePool>(v0);
    }

    public fun withdraw<T0>(arg0: &mut FeePool, arg1: 0x1::ascii::String, arg2: &0x659b2ca1b57be4c00874ea2fa07ce94d6580802ebb95a71758043010f9758050::capability::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::bag::contains_with_type<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.pool, arg1), 1);
        let v0 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.pool, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg3)
    }

    // decompiled from Move bytecode v6
}

