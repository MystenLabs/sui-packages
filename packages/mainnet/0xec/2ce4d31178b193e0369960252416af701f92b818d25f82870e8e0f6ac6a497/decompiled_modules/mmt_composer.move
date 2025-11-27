module 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_composer {
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

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg13, arg14);
        impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg13, arg14);
        impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg13, arg14);
        impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: u64) : (u128, u128, u128, u64) {
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5) + arg7;
        let (v1, v2, v3) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg2, arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), (0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::adjust_for_slippage((v0 as u128), arg4, 10000, false) as u128), arg6);
        (v1, v2, v3, v0)
    }

    fun impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg9);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg10, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg12)), arg3, v1);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_add_liquidity_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T3>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg9);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg10, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg12)), arg3, v1);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_add_liquidity_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T0, T2>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg9);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg1, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg10, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg12)), arg3, v1);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_add_liquidity_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::pool_id<T2, T0>(arg1), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T3>(arg1), (v1 as u128), v2);
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), arg10, arg11, arg12, arg13);
    }

    fun impl_swap_from_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_from_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T2>(arg1), (v1 as u128), v2);
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), arg10, arg11, arg12, arg13);
    }

    fun impl_swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_from_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, arg13);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T2, T0>(arg1), (v1 as u128), v2);
        let (_, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (v5 as u64), arg10, arg11, arg12, arg13);
    }

    fun impl_swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_from_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_swap_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T3>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg4, arg9, arg23);
        let (v4, v5) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T3>(arg4, arg10, arg23);
        let v6 = 0x2::tx_context::sender(arg23);
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v9 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v10 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v9);
        let v11 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg2);
        let (v12, v13, v14, v15, v16) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, v2, v4, 0, 0, arg12, arg13, arg22, arg23);
        let v17 = v16;
        let v18 = v15;
        let v19 = v12;
        let (v20, v21) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg4, arg5, v3, v13, arg22, arg23);
        let v22 = v21;
        let (v23, v24) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T3>(arg0, arg4, arg5, v5, v14, arg22, arg23);
        let v25 = v24;
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v18, v6, arg23);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v17, v6, arg23);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v22, v6, arg23);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v25, v6, arg23);
        let (v26, _, v28) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg7, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v7), v10, v11, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg2, v7), v13, arg22);
        assert!(v26 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v7), 3);
        let (v29, _, v31) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg8, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v8), v10, v11, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg2, v8), v14, arg22);
        assert!(v29 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v8), 3);
        let (v32, v33) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_price_guarded(arg6, v10, v11, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg2, v9), arg22);
        assert!(v32 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v9), 3);
        let v34 = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::safe_mul_div_u64(v28 + v31, 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::pow10((v10 as u8)), v33);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg4, arg5, v34, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v6, v7, v8, v13, v14, arg22, arg23);
        let v35 = 0x2::object::id_to_bytes(&v19);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T2, T3>(to_hex_ascii(&v35), 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3), arg12, arg13, v9, v7, v8, v0, v1, v20, v23, 0x2::coin::value<T2>(&v18) + 0x2::coin::value<T2>(&v22), 0x2::coin::value<T3>(&v17) + 0x2::coin::value<T3>(&v25), v13, v14, v34);
    }

    fun nibble_to_hex_char(arg0: u8) : 0x1::ascii::Char {
        if (arg0 < 10) {
            0x1::ascii::char(48 + arg0)
        } else {
            0x1::ascii::char(97 + arg0 - 10)
        }
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_and_add_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg16);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg12));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg13));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg14, arg15);
        impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg16, arg17);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_swap_from_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg16);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg12));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg13));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg14, arg15);
        impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg16, arg17);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg16);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg12));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg13));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg14, arg15);
        impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg16, arg17);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    entry fun swap_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg1);
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x1::vector::empty<vector<u8>>();
        let v6 = &mut v5;
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
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

    fun user_add_liquidity_internal<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: u128, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, u64, u64, u64, u64) {
        assert!(0x2::coin::value<T2>(&arg5) > 0 || 0x2::coin::value<T3>(&arg6) > 0, 2);
        let v0 = 0x2::tx_context::sender(arg11);
        let (v1, v2, v3, v4, v5) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0, arg8, arg9, arg10, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = v1;
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v7, v0, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v6, v0, arg11);
        let v9 = 0x2::object::id_to_bytes(&v8);
        (to_hex_ascii(&v9), v2, v3, 0x2::coin::value<T2>(&v7), 0x2::coin::value<T3>(&v6))
    }

    public fun user_add_liquidity_new_v2<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg8);
        let v1 = 0x2::coin::value<T3>(&arg9);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg3, arg8, arg12);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T3>(arg3, arg9, arg12);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::value<T2>(&v5);
        let v11 = 0x2::coin::value<T3>(&v9);
        let v12 = 0x2::coin::value<T2>(&v4);
        let v13 = 0x2::coin::value<T3>(&v8);
        let v14 = v10;
        let v15 = v11;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0x1::ascii::string(b"");
        let v19 = 0;
        let v20 = 0;
        let v21 = 0x2::tx_context::sender(arg12);
        let (v22, _, v24, v25) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3));
        let v26 = v25;
        let v27 = v24;
        let v28 = v22;
        if (0x1::vector::length<0x2::object::ID>(&v28) != 1) {
            if (v10 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg3, arg4, v5);
            } else {
                0x2::coin::destroy_zero<T2>(v5);
            };
            if (v11 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T3>(arg0, arg3, arg4, v9);
            } else {
                0x2::coin::destroy_zero<T3>(v9);
            };
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T2>(arg0, arg3, arg4, v4, arg11);
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T3>(arg0, arg3, arg4, v8, arg11);
        } else {
            let v29 = *0x1::vector::borrow<u32>(&v27, 0);
            v19 = v29;
            let v30 = *0x1::vector::borrow<u32>(&v26, 0);
            v20 = v30;
            let (v31, v32, v33, v34, v35) = user_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v5, v9, arg10, v29, v30, arg11, arg12);
            v15 = v33;
            v14 = v32;
            v18 = v31;
            let (v36, v37) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg3, arg4, v4, v32, arg11, arg12);
            let v38 = v37;
            let (v39, v40) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T3>(arg0, arg3, arg4, v8, v33, arg11, arg12);
            let v41 = v40;
            v12 = v36;
            v13 = v39;
            v16 = v34 + 0x2::coin::value<T2>(&v38);
            v17 = v35 + 0x2::coin::value<T3>(&v41);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v38, v21, arg12);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v41, v21, arg12);
        };
        let v42 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v43 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v44 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T2, T3>(v18, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg2), v19, v20, v44, v42, v43, v0, v1, v12, v13, v16, v17, v14, v15, ((0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v42, v44, arg5, arg6, arg7, (v14 as u64)) + 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v43, v44, arg5, arg6, arg7, (v15 as u64))) as u64));
        abort 0
    }

    public fun user_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: u32, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg8);
        let v1 = 0x2::coin::value<T3>(&arg9);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg3, arg8, arg14);
        let (v4, v5) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T3>(arg3, arg9, arg14);
        let v6 = 0x2::tx_context::sender(arg14);
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v9 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let (v10, v11, v12, v13, v14) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v2, v4, 0, 0, arg11, arg12, arg13, arg14);
        let v15 = v14;
        let v16 = v13;
        let v17 = v10;
        let (v18, v19) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg3, arg4, v3, v11, arg13, arg14);
        let v20 = v19;
        let (v21, v22) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T3>(arg0, arg3, arg4, v5, v12, arg13, arg14);
        let v23 = v22;
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v16, v6, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v15, v6, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v20, v6, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v23, v6, arg14);
        let v24 = ((0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v7, v9, arg5, arg6, arg7, (v11 as u64)) + 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v8, v9, arg5, arg6, arg7, (v12 as u64))) as u64);
        let v25 = 0x2::object::id_to_bytes(&v17);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T2, T3>(to_hex_ascii(&v25), 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg2), arg11, arg12, v9, v7, v8, v0, v1, v18, v21, 0x2::coin::value<T2>(&v16) + 0x2::coin::value<T2>(&v20), 0x2::coin::value<T3>(&v15) + 0x2::coin::value<T3>(&v23), v11, v12, v24);
        (v24, v11, v12)
    }

    fun user_add_ndlp<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, u64) {
        assert!(arg7 > 0 || arg8 > 0, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v2);
        let v4 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg1);
        let (v5, _, v7) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg5, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v0), v3, v4, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg1, v0), arg7, arg16);
        assert!(v5 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v0), 3);
        let (v8, _, v10) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg6, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v1), v3, v4, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg1, v1), arg8, arg16);
        assert!(v8 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v1), 3);
        let (v11, v12) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_price_guarded(arg4, v3, v4, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg1, v2), arg16);
        assert!(v11 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v2), 3);
        let v13 = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::safe_mul_div_u64(v7 + v10, 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::pow10((v3 as u8)), v12);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg2, arg3, v13, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::tx_context::sender(arg17), v0, v1, arg7, arg8, arg16, arg17);
        (v2, v0, v1, v13)
    }

    public entry fun user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        impl_user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
    }

    public fun user_deposit_and_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: u32, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        abort 0
    }

    public fun user_deposit_then_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T3>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg4, arg9, arg21);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T3>(arg4, arg10, arg21);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::value<T2>(&v5);
        let v11 = 0x2::coin::value<T3>(&v9);
        let v12 = 0x2::coin::value<T2>(&v4);
        let v13 = 0x2::coin::value<T3>(&v8);
        let v14 = v10;
        let v15 = v11;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0x1::ascii::string(b"");
        let v19 = 0;
        let v20 = 0;
        let v21 = 0x2::tx_context::sender(arg21);
        let (v22, _, v24, v25) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v26 = v25;
        let v27 = v24;
        let v28 = v22;
        if (0x1::vector::length<0x2::object::ID>(&v28) != 1) {
            if (v10 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, v5);
            } else {
                0x2::coin::destroy_zero<T2>(v5);
            };
            if (v11 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T3>(arg0, arg4, arg5, v9);
            } else {
                0x2::coin::destroy_zero<T3>(v9);
            };
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T2>(arg0, arg4, arg5, v4, arg20);
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T3>(arg0, arg4, arg5, v8, arg20);
        } else {
            let v29 = *0x1::vector::borrow<u32>(&v27, 0);
            v19 = v29;
            let v30 = *0x1::vector::borrow<u32>(&v26, 0);
            v20 = v30;
            let (v31, v32, v33, v34, v35) = user_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, v5, v9, arg11, v29, v30, arg20, arg21);
            v15 = v33;
            v14 = v32;
            v18 = v31;
            let (v36, v37) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg4, arg5, v4, v32, arg20, arg21);
            let v38 = v37;
            let (v39, v40) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T3>(arg0, arg4, arg5, v8, v33, arg20, arg21);
            let v41 = v40;
            v12 = v36;
            v13 = v39;
            v16 = v34 + 0x2::coin::value<T2>(&v38);
            v17 = v35 + 0x2::coin::value<T3>(&v41);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v38, v21, arg21);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(v41, v21, arg21);
        };
        let (v42, v43, v44, v45) = user_add_ndlp<T0, T1, T2, T3>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v14, v15, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T2, T3>(v18, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg3), v19, v20, v42, v43, v44, v0, v1, v12, v13, v16, v17, v14, v15, v45);
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T2>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T0>(&arg9);
        let v1 = 0x2::coin::value<T2>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T0>(arg4, arg9, arg21);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg4, arg10, arg21);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::value<T0>(&v5);
        let v11 = 0x2::coin::value<T2>(&v9);
        let v12 = 0x2::coin::value<T0>(&v4);
        let v13 = 0x2::coin::value<T2>(&v8);
        let v14 = v10;
        let v15 = v11;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0x1::ascii::string(b"");
        let v19 = 0;
        let v20 = 0;
        let v21 = 0x2::tx_context::sender(arg21);
        let (v22, _, v24, v25) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v26 = v25;
        let v27 = v24;
        let v28 = v22;
        if (0x1::vector::length<0x2::object::ID>(&v28) != 1) {
            if (v10 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_fund<T0, T1>(arg4, v5, arg21);
            } else {
                0x2::coin::destroy_zero<T0>(v5);
            };
            if (v11 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, v9);
            } else {
                0x2::coin::destroy_zero<T2>(v9);
            };
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T0>(arg0, arg4, arg5, v4, arg20);
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T2>(arg0, arg4, arg5, v8, arg20);
        } else {
            let v29 = *0x1::vector::borrow<u32>(&v27, 0);
            v19 = v29;
            let v30 = *0x1::vector::borrow<u32>(&v26, 0);
            v20 = v30;
            let (v31, v32, v33, v34, v35) = user_add_liquidity_internal<T0, T1, T0, T2>(arg0, arg1, arg3, arg4, arg5, v5, v9, arg11, v29, v30, arg20, arg21);
            v15 = v33;
            v14 = v32;
            v18 = v31;
            let (v36, v37) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T0>(arg0, arg4, arg5, v4, v32, arg20, arg21);
            let v38 = v37;
            let (v39, v40) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg4, arg5, v8, v33, arg20, arg21);
            let v41 = v40;
            v12 = v36;
            v13 = v39;
            v16 = v34 + 0x2::coin::value<T0>(&v38);
            v17 = v35 + 0x2::coin::value<T2>(&v41);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v38, v21, arg21);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v41, v21, arg21);
        };
        let (v42, v43, v44, v45) = user_add_ndlp<T0, T1, T0, T2>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v14, v15, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T0, T2>(v18, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>>(arg3), v19, v20, v42, v43, v44, v0, v1, v12, v13, v16, v17, v14, v15, v45);
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T0>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T0>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let (v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T2>(arg4, arg9, arg21);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::split_deposit_fee_coin<T0, T1, T0>(arg4, arg10, arg21);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::value<T2>(&v5);
        let v11 = 0x2::coin::value<T0>(&v9);
        let v12 = 0x2::coin::value<T2>(&v4);
        let v13 = 0x2::coin::value<T0>(&v8);
        let v14 = v10;
        let v15 = v11;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0x1::ascii::string(b"");
        let v19 = 0;
        let v20 = 0;
        let v21 = 0x2::tx_context::sender(arg21);
        let (v22, _, v24, v25) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v26 = v25;
        let v27 = v24;
        let v28 = v22;
        if (0x1::vector::length<0x2::object::ID>(&v28) != 1) {
            if (v10 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, v5);
            } else {
                0x2::coin::destroy_zero<T2>(v5);
            };
            if (v11 > 0) {
                0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::vault_add_fund<T0, T1>(arg4, v9, arg21);
            } else {
                0x2::coin::destroy_zero<T0>(v9);
            };
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T2>(arg0, arg4, arg5, v4, arg20);
            0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee_directly<T0, T1, T0>(arg0, arg4, arg5, v8, arg20);
        } else {
            let v29 = *0x1::vector::borrow<u32>(&v27, 0);
            v19 = v29;
            let v30 = *0x1::vector::borrow<u32>(&v26, 0);
            v20 = v30;
            let (v31, v32, v33, v34, v35) = user_add_liquidity_internal<T0, T1, T2, T0>(arg0, arg1, arg3, arg4, arg5, v5, v9, arg11, v29, v30, arg20, arg21);
            v15 = v33;
            v14 = v32;
            v18 = v31;
            let (v36, v37) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T2>(arg0, arg4, arg5, v4, v32, arg20, arg21);
            let v38 = v37;
            let (v39, v40) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::charge_deposit_fee<T0, T1, T0>(arg0, arg4, arg5, v8, v33, arg20, arg21);
            let v41 = v40;
            v12 = v36;
            v13 = v39;
            v16 = v34 + 0x2::coin::value<T2>(&v38);
            v17 = v35 + 0x2::coin::value<T0>(&v41);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v38, v21, arg21);
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v41, v21, arg21);
        };
        let (v42, v43, v44, v45) = user_add_ndlp<T0, T1, T2, T0>(arg0, arg2, arg4, arg5, arg6, arg7, arg8, v14, v15, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg20, arg21);
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::emit_user_dual_deposit_addLiquidity_event_v2<T2, T0>(v18, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>>(arg3), v19, v20, v42, v43, v44, v0, v1, v12, v13, v16, v17, v14, v15, v45);
    }

    public fun user_deposit_then_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        abort 0
    }

    public entry fun user_swap_coin_a_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun user_swap_coin_b_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T3>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

