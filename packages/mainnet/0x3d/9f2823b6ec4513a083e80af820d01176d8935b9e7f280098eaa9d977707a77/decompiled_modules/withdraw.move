module 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::withdraw {
    struct WithdrawRequestSubmittedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        sender: address,
        lp_token_amount: u64,
    }

    struct WithdrawQueueProcessedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        timestamp: u64,
    }

    struct WithdrawalClaimedEvent has copy, drop {
        vaultId: 0x2::object::ID,
        sender: address,
        coin_base: u64,
        coin_quote: u64,
    }

    public entry fun add_request<T0, T1, T2>(arg0: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: address, arg3: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::assert_current_version(arg3);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::add_withdraw_request<T0, T1, T2>(arg0, arg1, arg2, 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::constants::request_from_user());
        let v0 = WithdrawRequestSubmittedEvent{
            vaultId         : 0x2::object::id<0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>>(arg0),
            sender          : arg2,
            lp_token_amount : 0x2::coin::value<T2>(&arg1),
        };
        0x2::event::emit<WithdrawRequestSubmittedEvent>(v0);
    }

    public entry fun claim<T0, T1, T2>(arg0: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg1: address, arg2: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = claim_int<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg1);
    }

    public fun claim_int<T0, T1, T2>(arg0: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg1: address, arg2: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::assert_current_version(arg2);
        let (v0, v1) = 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::claim_withdrawal<T0, T1, T2>(arg0, arg1, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = WithdrawalClaimedEvent{
            vaultId    : 0x2::object::id<0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>>(arg0),
            sender     : arg1,
            coin_base  : 0x2::coin::value<T0>(&v3),
            coin_quote : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<WithdrawalClaimedEvent>(v4);
        (v3, v2)
    }

    public entry fun process_queue<T0, T1, T2>(arg0: &mut 0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::Version, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::version::assert_current_version(arg2);
        0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::process_withdrawals<T0, T1, T2>(arg0, arg1, arg4, arg3, arg5);
        let v0 = WithdrawQueueProcessedEvent{
            vaultId   : 0x2::object::id<0x3d9f2823b6ec4513a083e80af820d01176d8935b9e7f280098eaa9d977707a77::vault::Vault<T0, T1, T2>>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawQueueProcessedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

