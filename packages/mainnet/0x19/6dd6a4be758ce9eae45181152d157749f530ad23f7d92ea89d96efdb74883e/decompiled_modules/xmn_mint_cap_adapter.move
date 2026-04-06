module 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::xmn_mint_cap_adapter {
    struct CapKey has copy, drop, store {
        token_type: vector<u8>,
    }

    public(friend) fun transfer<T0>(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge_roles::BridgeCap, arg2: address, arg3: u64, arg4: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg5: &0x2::deny_list::DenyList, arg6: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::has_token_config<T0>(arg0)) {
            return false
        };
        if (!0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::get_token_is_mint_burn<T0>(arg0)) {
            return false
        };
        if (0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::get_stored_coin_balance<T0>(arg0) < arg3) {
            return false
        };
        if (!has_cap<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0))) {
            return false
        };
        mint<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0), arg4, arg5, arg3, arg2, arg6);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::subtract_token_balance<T0>(arg0, arg3);
        true
    }

    public(friend) fun burn<T0>(arg0: &0x2::object::UID, arg1: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg2: &0x2::deny_list::DenyList, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::burn<T0>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(arg0, cap_key<T0>()), arg2, arg3, arg4);
    }

    fun cap_key<T0>() : CapKey {
        CapKey{token_type: 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::utils::type_name_bytes<T0>()}
    }

    public fun deposit<T0>(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg5: &0x2::deny_list::DenyList, arg6: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::assert_is_compatible(arg0);
        assert!(has_cap<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0)), 20);
        let (v0, v1, v2, v3) = 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::deposit_validate_and_record<T0>(arg0, &arg1, arg2, true, arg3, arg6);
        burn<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0), arg4, arg5, arg1, arg6);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::events::emit_deposit_v1(v2, v3, 0x2::tx_context::sender(arg6), arg2, v1, v0);
    }

    public(friend) fun deregister<T0>(arg0: &mut 0x2::object::UID, arg1: address) {
        0x2::transfer::public_transfer<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(0x2::dynamic_object_field::remove<CapKey, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(arg0, cap_key<T0>()), arg1);
    }

    public fun execute_transfer<T0>(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::Bridge, arg1: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: vector<vector<u8>>, arg7: bool, arg8: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg9: &0x2::deny_list::DenyList, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::assert_bridge_is_compatible(arg0);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::assert_is_compatible(arg1);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::pre_execute_transfer<T0>(arg0, arg5, &arg2, &arg3, &arg4, &arg6, arg10, arg11);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        while (v1 < v0) {
            0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::record_transfer_result(arg0, arg5, transfer<T0>(arg1, 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::bridge_cap(arg0), *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg8, arg9, arg11));
            v1 = v1 + 1;
        };
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::bridge::finalize_batch(arg0, arg5, v0, arg7, arg10);
    }

    public(friend) fun has_cap<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_object_field::exists_with_type<CapKey, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(arg0, cap_key<T0>())
    }

    public(friend) fun mint<T0>(arg0: &0x2::object::UID, arg1: &mut 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<T0>, arg2: &0x2::deny_list::DenyList, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::mint<T0>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(arg0, cap_key<T0>()), arg2, arg3, arg4, arg5);
    }

    public(friend) fun register<T0>(arg0: &mut 0x2::object::UID, arg1: 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>) {
        0x2::dynamic_object_field::add<CapKey, 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>>(arg0, cap_key<T0>(), arg1);
    }

    public fun remove_token_from_whitelist<T0>(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: &mut 0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::assert_is_compatible(arg0);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::checkOwnerRole(arg0, arg1);
        assert!(has_cap<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0)), 20);
        let v0 = 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid_mut(arg0);
        deregister<T0>(v0, 0x2::tx_context::sender(arg1));
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::unwhitelist_token(arg0, 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::utils::type_name_bytes<T0>());
    }

    public fun whitelist_token<T0>(arg0: &mut 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::BridgeSafe, arg1: u64, arg2: u64, arg3: 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::MintCap<T0>, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::assert_is_compatible(arg0);
        assert!(!has_cap<T0>(0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid(arg0)), 21);
        0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::whitelist_token_internal<T0>(arg0, arg1, arg2, true, 0x1::option::some<0x2::object::ID>(arg4), true, false, arg5);
        let v0 = 0x196dd6a4be758ce9eae45181152d157749f530ad23f7d92ea89d96efdb74883e::safe::uid_mut(arg0);
        register<T0>(v0, arg3);
    }

    // decompiled from Move bytecode v7
}

