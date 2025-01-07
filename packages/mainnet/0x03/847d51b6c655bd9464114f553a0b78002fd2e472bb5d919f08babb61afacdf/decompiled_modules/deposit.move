module 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::deposit {
    struct DepositEvent has copy, drop {
        vaultId: 0x2::object::ID,
        poolId: 0x2::object::ID,
        sender: address,
        amount: u64,
        lp_tokens: u64,
    }

    public entry fun deposit<T0, T1, T2>(arg0: &mut 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::assert_current_version(arg7);
        let v0 = 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
        let v1 = DepositEvent{
            vaultId   : 0x2::object::id<0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>>(arg0),
            poolId    : 0x2::object::id<0xdee9::clob_v2::Pool<T0, T1>>(arg1),
            sender    : 0x2::tx_context::sender(arg8),
            amount    : 0x2::coin::value<T1>(&arg2),
            lp_tokens : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

