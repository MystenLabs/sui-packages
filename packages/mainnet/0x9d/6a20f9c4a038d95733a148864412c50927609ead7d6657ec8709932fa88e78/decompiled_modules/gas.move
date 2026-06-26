module 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::gas {
    public fun bucket_secs() : u64 {
        3600
    }

    public fun extract_gas(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::OperatorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_not_paused(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::operator_cap_vault_id(arg1) == 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_operator());
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::is_operator(arg0, 0x2::tx_context::sender(arg5)), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_operator());
        assert!(arg3 > 0, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::zero_amount());
        assert!(arg3 <= 150000000, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::gas_extract_exceeds_call_cap());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x1::type_name::with_defining_ids<0x2::sui::SUI>();
        let v2 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::borrow_account(arg0, arg2);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::accounting::available_balance(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::account_deposits(v2), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::account_locked(v2), &v1) >= arg3, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::insufficient_unlocked_balance());
        let v3 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::borrow_account_mut(arg0, arg2);
        let v4 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::prune_and_sum_gas_buckets(v3, v0, 86400, 3600);
        assert!(v4 + arg3 <= 100000000000, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::gas_extract_exceeds_24h_cap());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::add_gas_to_bucket(v3, v0, 3600, arg3);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::accounting::debit_deposits(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::account_deposits_mut(v3), v1, arg3);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::record_withdrawal<0x2::sui::SUI>(arg0, arg3);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_gas_extracted(arg2, arg3, v4 + arg3, v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::pools::user_split<0x2::sui::SUI>(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::borrow_user_pool_mut(arg0), arg3), arg5)
    }

    public fun max_extract_per_call() : u64 {
        150000000
    }

    public fun max_extract_per_receipt_24h() : u64 {
        100000000000
    }

    public fun window_secs() : u64 {
        86400
    }

    // decompiled from Move bytecode v7
}

