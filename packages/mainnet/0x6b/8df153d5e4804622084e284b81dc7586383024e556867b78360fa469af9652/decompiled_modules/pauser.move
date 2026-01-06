module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::pauser {
    struct PauserRole has drop {
        dummy_field: bool,
    }

    public(friend) fun is_pauser_role<T0: drop>() : bool {
        0x1::type_name::with_defining_ids<PauserRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public fun pause<T0, T1: drop>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, PauserRole>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::admin::is_admin_role<T1>(), 13835058166951313409);
        assert!(!is_pauser_role<T1>(), 13835339646223122435);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::pause<T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles_mut<T0>(arg0));
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_pause_event<T0, T1>(0x2::tx_context::sender(arg2), true);
    }

    public fun resume<T0, T1: drop>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, PauserRole>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::unpause<T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles_mut<T0>(arg0));
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_pause_event<T0, T1>(0x2::tx_context::sender(arg2), false);
    }

    // decompiled from Move bytecode v6
}

