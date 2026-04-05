module 0x98ce24e3db39faf3770bad60f32257951bd2d6d89a1e1ec8b313487b76d0be1::flash_settler {
    struct FlashArbSettled has copy, drop {
        vault_id: 0x2::object::ID,
        keeper: address,
        gross_profit: u64,
        keeper_cut: u64,
        vault_share: u64,
        reward_bps: u64,
    }

    public fun settle<T0>(arg0: &mut 0x98ce24e3db39faf3770bad60f32257951bd2d6d89a1e1ec8b313487b76d0be1::executor::Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 1);
        let v1 = 0x98ce24e3db39faf3770bad60f32257951bd2d6d89a1e1ec8b313487b76d0be1::executor::current_reward_bps<T0>(arg0, arg3);
        let v2 = v0 * v1 / 10000;
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x98ce24e3db39faf3770bad60f32257951bd2d6d89a1e1ec8b313487b76d0be1::executor::deposit_and_record<T0>(arg0, v3, v0, v2);
        let v4 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg4), v4);
        let v5 = FlashArbSettled{
            vault_id     : 0x2::object::id<0x98ce24e3db39faf3770bad60f32257951bd2d6d89a1e1ec8b313487b76d0be1::executor::Vault<T0>>(arg0),
            keeper       : v4,
            gross_profit : v0,
            keeper_cut   : v2,
            vault_share  : 0x2::balance::value<T0>(&v3),
            reward_bps   : v1,
        };
        0x2::event::emit<FlashArbSettled>(v5);
    }

    // decompiled from Move bytecode v6
}

