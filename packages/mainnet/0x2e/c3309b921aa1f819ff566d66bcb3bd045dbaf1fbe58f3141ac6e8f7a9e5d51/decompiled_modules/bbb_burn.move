module 0x2ec3309b921aa1f819ff566d66bcb3bd045dbaf1fbe58f3141ac6e8f7a9e5d51::bbb_burn {
    struct Burn has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    struct Burned has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public fun burn<T0>(arg0: &Burn, arg1: &mut 0x2ec3309b921aa1f819ff566d66bcb3bd045dbaf1fbe58f3141ac6e8f7a9e5d51::bbb_vault::BBBVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2ec3309b921aa1f819ff566d66bcb3bd045dbaf1fbe58f3141ac6e8f7a9e5d51::bbb_vault::withdraw<T0>(arg1);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v1 = Burned{
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<Burned>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), @0x0);
    }

    public fun coin_type(arg0: &Burn) : &0x1::type_name::TypeName {
        &arg0.coin_type
    }

    public fun new<T0>(arg0: &0x2ec3309b921aa1f819ff566d66bcb3bd045dbaf1fbe58f3141ac6e8f7a9e5d51::bbb_admin::BBBAdminCap) : Burn {
        Burn{coin_type: 0x1::type_name::get<T0>()}
    }

    // decompiled from Move bytecode v6
}

