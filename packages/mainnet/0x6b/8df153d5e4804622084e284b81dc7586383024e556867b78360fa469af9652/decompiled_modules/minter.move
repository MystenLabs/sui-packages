module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::minter {
    struct MinterRole<phantom T0> has drop {
        dummy_field: bool,
    }

    struct MinterRateLimit<phantom T0> has copy, drop, store {
        max_amount: u64,
        amount_used: u64,
    }

    public fun mint<T0>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, MinterRole<T0>>, arg2: &0x2::deny_list::DenyList, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, bool>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::valid_recipients_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0)), v0), 13835058270030528513);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg2, v0), 13835058278620463105);
        assert!(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::contains<MinterRole<T0>, MinterRateLimit<T0>>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles<T0>(arg0), v0), 13835902712140922887);
        let v1 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::config_mut<MinterRole<T0>, MinterRateLimit<T0>>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles_mut<T0>(arg0), v0);
        check_and_update_rate_limit<T0>(v1, arg3);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_minted_event<T0>(arg3, v0, v0);
        0x2::coin::mint<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::treasury_cap_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0)), arg3, arg4)
    }

    fun check_and_update_rate_limit<T0>(arg0: &mut MinterRateLimit<T0>, arg1: u64) {
        assert!(arg0.amount_used + arg1 <= arg0.max_amount, 13835340041360113667);
        arg0.amount_used = arg0.amount_used + arg1;
    }

    public(friend) fun default_mint_rate_limit<T0>() : MinterRateLimit<T0> {
        MinterRateLimit<T0>{
            max_amount  : 0,
            amount_used : 0,
        }
    }

    public(friend) fun is_minter_role<T0: drop, T1>() : bool {
        0x1::type_name::with_defining_ids<MinterRole<T1>>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public(friend) fun update_and_reset_rate_limit<T0>(arg0: &mut MinterRateLimit<T0>, arg1: u64) {
        arg0.max_amount = arg1;
        arg0.amount_used = 0;
    }

    public fun wrap<T0, T1>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, MinterRole<T1>>, arg2: &0x2::deny_list::DenyList, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::is_valid_stablecoin_mint_recipient<T0, T1>(arg0, v0), 13835058437534253057);
        assert!(!0x2::coin::deny_list_v2_contains_next_epoch<T1>(arg2, v0), 13835058446124187649);
        let v1 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::config_mut<MinterRole<T1>, MinterRateLimit<T1>>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles_mut<T0>(arg0), v0);
        let v2 = 0x2::coin::value<T0>(&arg3);
        check_and_update_rate_limit<T1>(v1, v2);
        assert!(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::is_token_registered<T0, T1>(arg0), 13835621434732576773);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_wrapped_event<T0, T1>(v2, v0, v0);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::stablecoin::wrap<T0, T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::stablecoin_mut<T0, T1>(arg0), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

