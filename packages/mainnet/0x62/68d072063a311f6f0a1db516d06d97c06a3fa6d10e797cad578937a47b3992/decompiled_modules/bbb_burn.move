module 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_burn {
    struct BurnEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct Burn has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct BurnPromise {
        burn: Burn,
    }

    public fun burn<T0>(arg0: BurnPromise, arg1: &mut 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::BBBVault, arg2: &mut 0x2::tx_context::TxContext) {
        let BurnPromise { burn: v0 } = arg0;
        let v1 = 0x1::type_name::get<T0>();
        assert!(v1 == v0.coin_type, 1000);
        let v2 = 0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_vault::withdraw<T0>(arg1);
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
            return
        };
        let v3 = BurnEvent{
            coin_type : 0x1::type_name::into_string(v1),
            amount    : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<BurnEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg2), @0x0);
    }

    public fun coin_type(arg0: &Burn) : &0x1::type_name::TypeName {
        &arg0.coin_type
    }

    public fun inner(arg0: &BurnPromise) : &Burn {
        &arg0.burn
    }

    public fun new<T0>(arg0: &0x6268d072063a311f6f0a1db516d06d97c06a3fa6d10e797cad578937a47b3992::bbb_admin::BBBAdminCap) : Burn {
        Burn{coin_type: 0x1::type_name::get<T0>()}
    }

    public(friend) fun new_promise(arg0: Burn) : BurnPromise {
        BurnPromise{burn: arg0}
    }

    // decompiled from Move bytecode v6
}

