module 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_composer {
    struct SwapRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        input_amount: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault: u64,
    }

    struct SwapFromRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        restore: bool,
        amount_in_vault_before: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault_after: u64,
    }

    struct AddLiquidityRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        key_storage: vector<u8>,
        amount_in_vault: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct UserDualDepositAndAddLiquidity<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        vault_token: 0x1::ascii::String,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        input_amount_token_a: u64,
        input_amount_token_b: u64,
        refund_amount_token_a: u64,
        refund_amount_token_b: u64,
        amount_token_a: u64,
        amount_token_b: u64,
        amount_deposit_to_vault: u64,
    }

    struct UserZapInDepositAndAddLiquidity<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        vault_token: 0x1::ascii::String,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        input_amount_token_a: u64,
        input_amount_token_b: u64,
        refund_amount_token_a: u64,
        refund_amount_token_b: u64,
        amount_token_a: u64,
        amount_token_b: u64,
        amount_deposit_to_vault: u64,
        token_deposit: 0x1::ascii::String,
        token_deposit_amount: u64,
        swap_amount_in: u64,
        swap_amount_out: u64,
    }

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: u64) : (u128, u128, u128, u64) {
        let v0 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5) + arg7;
        let (v1, v2, v3) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::estimate_token(arg2, arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((v0 as u128), arg4, 10000, false) as u128), arg6);
        (v1, v2, v3, v0)
    }

    fun impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), 0, 0, arg9, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_add_liquidity_record_event<T2, T3>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), 0, 0, arg9, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_add_liquidity_record_event<T0, T2>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T2>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), 0, 0, arg9, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_add_liquidity_record_event<T2, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T0>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T3>(arg1), (v1 as u128), v2);
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    fun impl_swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_from_record_event<T2, T3>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T2>(arg1), (v1 as u128), v2);
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    fun impl_swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_from_record_event<T0, T2>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T0>(arg1), (v1 as u128), v2);
        let (_, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), 0, 0, arg10, arg11);
    }

    fun impl_swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg10);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_from_record_event<T2, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_record_event<T2, T3>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1), arg7, arg8, arg5, v0, v1, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_record_event<T0, T2>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1), arg7, arg8, arg5, v0, v1, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_swap_record_event<T2, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1), arg7, arg8, arg5, v0, v1, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun nibble_to_hex_char(arg0: u8) : 0x1::ascii::Char {
        if (arg0 < 10) {
            0x1::ascii::char(48 + arg0)
        } else {
            0x1::ascii::char(97 + arg0 - 10)
        }
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_and_add_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_swap_from_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        impl_swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    entry fun swap_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        impl_swap_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12, arg13);
    }

    fun to_hex_ascii(arg0: &vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::ascii::string(b"0x");
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            0x1::ascii::push_char(&mut v0, nibble_to_hex_char(v2 >> 4 & 15));
            0x1::ascii::push_char(&mut v0, nibble_to_hex_char(v2 & 15));
            v1 = v1 + 1;
        };
        v0
    }

    fun user_add_liquidity_internal<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: u128, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, u64, u64, u64, u64) {
        assert!(0x2::coin::value<T2>(&arg5) > 0 || 0x2::coin::value<T3>(&arg6) > 0, 2);
        let v0 = 0x2::tx_context::sender(arg11);
        let (v1, v2, v3, v4, v5) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0, arg8, arg9, arg10, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = v1;
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T2>(v7, v0, arg11);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T3>(v6, v0, arg11);
        let v9 = 0x2::object::id_to_bytes(&v8);
        (to_hex_ascii(&v9), v2, v3, 0x2::coin::value<T2>(&v7), 0x2::coin::value<T3>(&v6))
    }

    fun user_add_ndlp<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, u64) {
        assert!(arg7 > 0 || arg8 > 0, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg1);
        let v4 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v2);
        let (v5, _, v7) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::get_amount_with_price_feed(arg5, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v0), v4, v3, arg7, arg16);
        assert!(v5 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v0), 3);
        let (v8, _, v10) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::get_amount_with_price_feed(arg6, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v1), v4, v3, arg8, arg16);
        assert!(v8 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v1), 3);
        let (v11, v12) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::get_price(arg4, v4, v3, arg16);
        assert!(v11 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v2), 3);
        let v13 = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::safe_mul_div_u64(v7 + v10, 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::fast_price_feed::pow10((v4 as u8)), v12);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg2, arg3, v13, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::tx_context::sender(arg17), v0, v1, arg7, arg8, arg16, arg17);
        (v2, v0, v1, v13)
    }

    public entry fun user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun user_deposit_then_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T3>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = v0;
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::ascii::string(b"");
        let v7 = 0;
        let v8 = 0;
        let (v9, _, v11, v12) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg9);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
            if (v1 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_harvest_assets<T0, T1, T3>(arg0, arg4, arg5, arg10);
            } else {
                0x2::coin::destroy_zero<T3>(arg10);
            };
        } else {
            let v16 = *0x1::vector::borrow<u32>(&v14, 0);
            v7 = v16;
            let v17 = *0x1::vector::borrow<u32>(&v13, 0);
            v8 = v17;
            let (v18, v19, v20, v21, v22) = user_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, arg9, arg10, arg11, v16, v17, arg20, arg21);
            v5 = v22;
            v4 = v21;
            v3 = v20;
            v2 = v19;
            v6 = v18;
        };
        let (v23, v24, v25, v26) = user_add_ndlp<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v2, v3, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_user_dual_deposit_addLiquidity_event<T2, T3>(v6, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T2>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T0>(&arg9);
        let v1 = 0x2::coin::value<T2>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = v0;
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::ascii::string(b"");
        let v7 = 0;
        let v8 = 0;
        let (v9, _, v11, v12) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_fund<T0, T1>(arg4, arg9, arg21);
            } else {
                0x2::coin::destroy_zero<T0>(arg9);
            };
            if (v1 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg10);
            } else {
                0x2::coin::destroy_zero<T2>(arg10);
            };
        } else {
            let v16 = *0x1::vector::borrow<u32>(&v14, 0);
            v7 = v16;
            let v17 = *0x1::vector::borrow<u32>(&v13, 0);
            v8 = v17;
            let (v18, v19, v20, v21, v22) = user_add_liquidity_internal<T0, T1, T0, T2>(arg0, arg1, arg3, arg4, arg5, arg9, arg10, arg11, v16, v17, arg20, arg21);
            v5 = v22;
            v4 = v21;
            v3 = v20;
            v2 = v19;
            v6 = v18;
        };
        let (v23, v24, v25, v26) = user_add_ndlp<T0, T1, T0, T2>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v2, v3, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_user_dual_deposit_addLiquidity_event<T0, T2>(v6, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T0>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T0>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = v0;
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::ascii::string(b"");
        let v7 = 0;
        let v8 = 0;
        let (v9, _, v11, v12) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg9);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
            if (v1 > 0) {
                0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::vault_add_fund<T0, T1>(arg4, arg10, arg21);
            } else {
                0x2::coin::destroy_zero<T0>(arg10);
            };
        } else {
            let v16 = *0x1::vector::borrow<u32>(&v14, 0);
            v7 = v16;
            let v17 = *0x1::vector::borrow<u32>(&v13, 0);
            v8 = v17;
            let (v18, v19, v20, v21, v22) = user_add_liquidity_internal<T0, T1, T2, T0>(arg0, arg1, arg3, arg4, arg5, arg9, arg10, arg11, v16, v17, arg20, arg21);
            v5 = v22;
            v4 = v21;
            v3 = v20;
            v2 = v19;
            v6 = v18;
        };
        let (v23, v24, v25, v26) = user_add_ndlp<T0, T1, T2, T0>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v2, v3, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::emit_user_dual_deposit_addLiquidity_event<T2, T0>(v6, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public entry fun user_swap_coin_a_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun user_swap_coin_b_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T3>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

