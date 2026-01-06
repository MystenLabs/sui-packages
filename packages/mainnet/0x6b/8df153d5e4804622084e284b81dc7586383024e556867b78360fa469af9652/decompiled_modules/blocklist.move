module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::blocklist {
    struct BlocklistRole has drop {
        dummy_field: bool,
    }

    public fun add_to_ledger_token_blocklist<T0>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BlocklistRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::deny_cap_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0));
        0x1::vector::reverse<address>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg3);
            0x2::coin::deny_list_v2_add<T0>(arg2, v0, v2, arg4);
            0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_added_to_blocklist_event<T0, T0>(v2, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    public fun add_to_stablecoin_blocklist<T0, T1>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BlocklistRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::stablecoin::deny_cap_mut<T0, T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::stablecoin_mut<T0, T1>(arg0));
        0x1::vector::reverse<address>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg3);
            0x2::coin::deny_list_v2_add<T1>(arg2, v0, v2, arg4);
            0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_added_to_blocklist_event<T0, T1>(v2, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    public fun remove_from_ledger_token_blocklist<T0>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BlocklistRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::ledger_token::deny_cap_mut<T0>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::ledger_token_mut<T0>(arg0));
        0x1::vector::reverse<address>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg3);
            0x2::coin::deny_list_v2_remove<T0>(arg2, v0, v2, arg4);
            0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_removed_from_blocklist_event<T0, T0>(v2, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    public fun remove_from_stablecoin_blocklist<T0, T1>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth::Auth<T0, BlocklistRole>, arg2: &mut 0x2::deny_list::DenyList, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::stablecoin::deny_cap_mut<T0, T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::stablecoin_mut<T0, T1>(arg0));
        0x1::vector::reverse<address>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg3);
            0x2::coin::deny_list_v2_remove<T1>(arg2, v0, v2, arg4);
            0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::events::emit_removed_from_blocklist_event<T0, T1>(v2, 0x2::tx_context::sender(arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    // decompiled from Move bytecode v6
}

