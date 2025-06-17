module 0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::batch_deposit_v2 {
    struct BatchDepositCompleted has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        nft_count: u64,
    }

    public entry fun batch_deposit_10<T0: store + key>(arg0: &mut 0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2, arg1: T0, arg2: T0, arg3: T0, arg4: T0, arg5: T0, arg6: T0, arg7: T0, arg8: T0, arg9: T0, arg10: T0, arg11: &mut 0x2::tx_context::TxContext) {
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg1, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg2, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg3, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg4, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg5, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg6, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg7, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg8, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg9, arg11);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg10, arg11);
        let v0 = BatchDepositCompleted{
            pool_id   : 0x2::object::id<0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2>(arg0),
            depositor : 0x2::tx_context::sender(arg11),
            nft_count : 10,
        };
        0x2::event::emit<BatchDepositCompleted>(v0);
    }

    public entry fun batch_deposit_20<T0: store + key>(arg0: &mut 0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2, arg1: T0, arg2: T0, arg3: T0, arg4: T0, arg5: T0, arg6: T0, arg7: T0, arg8: T0, arg9: T0, arg10: T0, arg11: T0, arg12: T0, arg13: T0, arg14: T0, arg15: T0, arg16: T0, arg17: T0, arg18: T0, arg19: T0, arg20: T0, arg21: &mut 0x2::tx_context::TxContext) {
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg1, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg2, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg3, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg4, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg5, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg6, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg7, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg8, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg9, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg10, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg11, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg12, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg13, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg14, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg15, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg16, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg17, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg18, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg19, arg21);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg20, arg21);
        let v0 = BatchDepositCompleted{
            pool_id   : 0x2::object::id<0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2>(arg0),
            depositor : 0x2::tx_context::sender(arg21),
            nft_count : 20,
        };
        0x2::event::emit<BatchDepositCompleted>(v0);
    }

    public entry fun batch_deposit_5<T0: store + key>(arg0: &mut 0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2, arg1: T0, arg2: T0, arg3: T0, arg4: T0, arg5: T0, arg6: &mut 0x2::tx_context::TxContext) {
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg1, arg6);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg2, arg6);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg3, arg6);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg4, arg6);
        0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::add_nft_to_pool<T0>(arg0, arg5, arg6);
        let v0 = BatchDepositCompleted{
            pool_id   : 0x2::object::id<0x81a27789d618d02cdc3bbda97625dbfc93887237581a1d68575265d700393f0e::nft_gated_claim_pool_v2::NFTGatedClaimPoolV2>(arg0),
            depositor : 0x2::tx_context::sender(arg6),
            nft_count : 5,
        };
        0x2::event::emit<BatchDepositCompleted>(v0);
    }

    // decompiled from Move bytecode v6
}

