module 0x88753520710e6dfb294a2803452dea8b99f883279ac793dac1cc5cf8c3705075::bbb_burn {
    struct BurnEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct Burn has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
    }

    public fun burn<T0>(arg0: &Burn, arg1: &mut 0x88753520710e6dfb294a2803452dea8b99f883279ac793dac1cc5cf8c3705075::bbb_vault::BBBVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(v0 == arg0.coin_type, 1000);
        let v1 = 0x88753520710e6dfb294a2803452dea8b99f883279ac793dac1cc5cf8c3705075::bbb_vault::withdraw<T0>(arg1);
        if (0x2::balance::value<T0>(&v1) == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let v2 = BurnEvent{
            coin_type : 0x1::type_name::into_string(v0),
            amount    : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<BurnEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), @0x9526d8dbc3d24a9bc43a1c87f205ebd8d534155bc9b57771e2bf3aa6e4466686);
    }

    public fun coin_type(arg0: &Burn) : &0x1::type_name::TypeName {
        &arg0.coin_type
    }

    public fun new<T0>(arg0: &0x88753520710e6dfb294a2803452dea8b99f883279ac793dac1cc5cf8c3705075::bbb_admin::BBBAdminCap) : Burn {
        Burn{coin_type: 0x1::type_name::get<T0>()}
    }

    // decompiled from Move bytecode v6
}

