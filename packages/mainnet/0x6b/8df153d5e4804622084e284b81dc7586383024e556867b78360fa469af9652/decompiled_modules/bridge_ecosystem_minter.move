module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::bridge_ecosystem_minter {
    struct BridgeEcosystemMinterRole has drop {
        dummy_field: bool,
    }

    public fun mint<T0>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BridgeEcosystemMinterRole>, arg2: &0x2::deny_list::DenyList, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, bool>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::valid_recipients_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0)), v0), 13835058209900986369);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, v0), 13835058218490920961);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_minted_event<T0>(arg3, v0, v0);
        0x2::coin::mint<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::treasury_cap_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0)), arg3, arg4)
    }

    public fun wrap<T0, T1>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BridgeEcosystemMinterRole>, arg2: &0x2::deny_list::DenyList, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::is_valid_stablecoin_mint_recipient<T0, T1>(arg0, v0), 13835058343044972545);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T1>(arg2, v0), 13835058351634907137);
        assert!(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::is_token_registered<T0, T1>(arg0), 13835339848086585347);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_wrapped_event<T0, T1>(0x2::coin::value<T0>(&arg3), v0, v0);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::stablecoin::wrap<T0, T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::stablecoin_mut<T0, T1>(arg0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

