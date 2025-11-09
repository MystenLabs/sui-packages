module 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_composer {
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

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg10));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg13, arg14);
    }

    fun get_coin_a_for_deposit_and_add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u128, arg4: u64, arg5: u64) : u64 {
        let (_, v1, v2) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), (arg5 as u128), false);
        if (v1 <= (arg4 as u128) && v2 <= (arg5 as u128)) {
            (0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::adjust_for_slippage((v1 as u128), arg3, 10000, false) as u64)
        } else {
            let v4 = (arg4 as u128);
            let v5 = 0;
            while (v5 < 10) {
                let v6 = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::adjust_for_slippage(v4, arg3, 10000, false);
                v4 = v6;
                if (v6 <= v1) {
                    break
                };
                v5 = v5 + 1;
            };
            (v4 as u64)
        }
    }

    fun get_liquidity_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: u64) : (u128, u128, u128, u64) {
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5) + arg7;
        let (v1, v2, v3) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), (0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::adjust_for_slippage((v0 as u128), arg4, 10000, false) as u128), arg6);
        (v1, v2, v3, v0)
    }

    fun impl_add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_liquidity_for_add_liquidity<T2, T3, T0, T1>(arg2, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, v2, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_add_liquidity_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_liquidity_for_add_liquidity<T0, T2, T0, T1>(arg2, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, v2, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_add_liquidity_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u32, arg6: u32, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg7);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5) = get_liquidity_for_add_liquidity<T2, T0, T0, T1>(arg2, arg3, arg5, arg6, (0x2::bcs::peel_u16(&mut v0) as u128), v1, arg8, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, v2, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10)), arg3, v1);
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_add_liquidity_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), arg5, arg6, v1, v5, v2, (v3 as u64), (v4 as u64), 0, 0);
    }

    fun impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, v3, arg10, arg11);
    }

    fun impl_swap_and_add_liquidity_with_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: u32, arg10: u32, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v2 = arg8 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg9, arg10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg9, arg10, arg4, arg5, v3, arg11, arg12);
    }

    fun impl_swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_from_record_with_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg8), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg10, arg11);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8);
        let v4 = 0;
        if (arg9) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg7, arg8, arg9, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, v3, arg10, arg11);
    }

    fun impl_swap_have_coin_a_in_vault_and_add_liquidity_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: u32, arg10: u32, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v2 = arg8 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg9, arg10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T2>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10, arg4, arg5, v3, arg11, arg12);
    }

    fun impl_swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_a_in_vault_from_record_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg8), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg10, arg11);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8);
        let v4 = 0;
        if (arg9) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), arg7, arg8, arg9, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v2 = arg7 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg8, arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T0>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, v3, arg10, arg11);
    }

    fun impl_swap_have_coin_b_in_vault_and_add_liquidity_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: u32, arg10: u32, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        let v2 = arg8 && false || true;
        let (v3, _, _) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::liquidity_math::estimate_token(arg9, arg10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T0>(arg2), (v1 as u128), v2);
        let (_, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg9, arg10, arg4, arg5, v3, arg11, arg12);
    }

    fun impl_swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), arg6, arg7, arg8, v0, v1, v2, v4);
    }

    fun impl_swap_have_coin_b_in_vault_from_record_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg8), 1);
        let v0 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        let (v1, v2) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7, arg10, arg11);
        let v3 = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::remove_dynamic_field<T0, T1, u64>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8);
        let v4 = 0;
        if (arg9) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(v3), arg4, arg8, (v2 as u64));
            v4 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg8);
        };
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_from_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), arg7, arg8, arg9, v0, v1, v2, v4);
    }

    fun impl_swap_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9) || !arg10 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg12)), arg4, arg9, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T0, T2>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2), arg8, arg9, arg6, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg9));
    }

    fun impl_swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), arg7, arg8, arg5, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8));
    }

    fun impl_swap_record_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9) || !arg10 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg12)), arg4, arg9, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T2, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2), arg8, arg9, arg6, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg9));
    }

    fun impl_swap_record_with_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 && !0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9) || !arg10 && 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::check_dynamic_field<T0, T1>(arg4, arg9), 1);
        let (v0, v1) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_swap_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::increase_balance_dynamic_field<T0, T1>(arg5, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::borrow_access_cap(arg0, arg12)), arg4, arg9, (v1 as u64));
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_swap_record_event<T2, T3>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg8, arg9, arg6, v0, v1, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_dynamic_field<T0, T1, u64>(arg4, arg9));
    }

    fun impl_user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, false, 0x1::ascii::string(0x1::vector::empty<u8>()), 0, 0, 0, arg22, arg23);
    }

    fun nibble_to_hex_char(arg0: u8) : 0x1::ascii::Char {
        if (arg0 < 10) {
            0x1::ascii::char(48 + arg0)
        } else {
            0x1::ascii::char(97 + arg0 - 10)
        }
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_and_add_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_and_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    entry fun swap_and_add_liquidity_with_auth_and_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: u32, arg12: u32, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_and_add_liquidity_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_from_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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

    entry fun swap_from_record_with_auth_with_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg12, arg13);
        impl_swap_from_record_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    entry fun swap_have_coin_a_in_vault_and_add_liquidity_with_auth_and_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: u32, arg12: u32, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_have_coin_a_in_vault_and_add_liquidity_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_a_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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

    entry fun swap_have_coin_a_in_vault_from_record_with_auth_and_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg12, arg13);
        impl_swap_have_coin_a_in_vault_from_record_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_and_add_liquidity_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: u32, arg11: u32, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg12, arg13);
        impl_swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    entry fun swap_have_coin_b_in_vault_and_add_liquidity_with_auth_and_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: u32, arg12: u32, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u32>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_have_coin_b_in_vault_and_add_liquidity_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_have_coin_b_in_vault_from_record_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u128, arg8: bool, arg9: vector<u8>, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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

    entry fun swap_have_coin_b_in_vault_from_record_with_auth_and_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg12, arg13);
        impl_swap_have_coin_b_in_vault_from_record_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg14, arg15);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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

    entry fun swap_record_have_coin_a_in_vault_with_auth_with_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_record_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun swap_record_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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

    entry fun swap_record_have_coin_b_in_vault_with_auth_and_partner<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_record_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
    }

    entry fun swap_record_with_auth<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<u8>, arg11: bool, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg14);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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

    entry fun swap_record_with_auth_and_partner<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<u8>, arg12: bool, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::check_time(arg0, arg5, arg6, arg15);
        let v0 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner>(arg7);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = &mut v6;
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v5));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<vector<u8>>(&arg11));
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<bool>(&arg12));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg13, arg14);
        impl_swap_record_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
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

    fun user_add_liquidity_internal<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: u128, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, u64, u64, u64, u64) {
        assert!(arg7 >= 0 && arg7 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg5);
        let v1 = 0x2::coin::value<T3>(&arg6);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = get_coin_a_for_deposit_and_add_liquidity<T2, T3>(arg2, arg8, arg9, arg7, v0, v1);
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = 0;
        let v5 = if (v2 < v0) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(arg5, v3, arg11);
            v4 = v0 - v2;
            0x2::coin::split<T2>(&mut arg5, v2, arg11)
        } else {
            arg5
        };
        let v6 = v5;
        let (v7, v8, v9) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, &mut v6, &mut arg6, arg8, arg9, arg10, arg11);
        let v10 = v7;
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v6, v3, arg11);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(arg6, v3, arg11);
        let v11 = 0x2::object::id_to_bytes(&v10);
        (to_hex_ascii(&v11), v8, v9, v4 + 0x2::coin::value<T2>(&v6), 0x2::coin::value<T3>(&arg6))
    }

    public fun user_add_liquidity_new_v2<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg8);
        let v1 = 0x2::coin::value<T3>(&arg9);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = v0;
        let v3 = v1;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::ascii::string(b"");
        let v7 = 0;
        let v8 = 0;
        let (v9, _, v11, v12) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg3, arg4, arg8);
            } else {
                0x2::coin::destroy_zero<T2>(arg8);
            };
            if (v1 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T3>(arg0, arg3, arg4, arg9);
            } else {
                0x2::coin::destroy_zero<T3>(arg9);
            };
        } else {
            let v16 = *0x1::vector::borrow<u32>(&v14, 0);
            v7 = v16;
            let v17 = *0x1::vector::borrow<u32>(&v13, 0);
            v8 = v17;
            let (v18, v19, v20, v21, v22) = user_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg8, arg9, arg10, v16, v17, arg11, arg12);
            v5 = v22;
            v4 = v21;
            v3 = v20;
            v2 = v19;
            v6 = v18;
        };
        let v23 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v24 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v25 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_user_dual_deposit_addLiquidity_event<T2, T3>(v6, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), v7, v8, v25, v23, v24, v0, v1, v4, v5, v2, v3, ((0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v23, v25, arg5, arg6, arg7, (v2 as u64)) + 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v24, v25, arg5, arg6, arg7, (v3 as u64))) as u64));
        abort 0
    }

    public fun user_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: u32, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg8);
        let v1 = 0x2::coin::value<T3>(&arg9);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = get_coin_a_for_deposit_and_add_liquidity<T2, T3>(arg2, arg11, arg12, arg10, v0, v1);
        let v3 = 0x2::tx_context::sender(arg14);
        let v4 = 0;
        let v5 = if (v2 < v0) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(arg8, v3, arg14);
            v4 = v0 - v2;
            0x2::coin::split<T2>(&mut arg8, v2, arg14)
        } else {
            arg8
        };
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v9 = v5;
        let (v10, v11, v12) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, &mut v9, &mut arg9, arg11, arg12, arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v9, v3, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(arg9, v3, arg14);
        let v13 = ((0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v6, v8, arg5, arg6, arg7, (v11 as u64)) + 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_token_out_amount(v7, v8, arg5, arg6, arg7, (v12 as u64))) as u64);
        let v14 = UserDualDepositAndAddLiquidity<T2, T3>{
            lp_id                   : v10,
            vault_id                : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg3),
            pool_id                 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
            tick_lower              : arg11,
            tick_upper              : arg12,
            vault_token             : v8,
            token_a                 : v6,
            token_b                 : v7,
            input_amount_token_a    : v0,
            input_amount_token_b    : v1,
            refund_amount_token_a   : v4 + 0x2::coin::value<T2>(&v9),
            refund_amount_token_b   : 0x2::coin::value<T3>(&arg9),
            amount_token_a          : v11,
            amount_token_b          : v12,
            amount_deposit_to_vault : v13,
        };
        0x2::event::emit<UserDualDepositAndAddLiquidity<T2, T3>>(v14);
        (v13, v11, v12)
    }

    fun user_add_ndlp<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String, u64) {
        assert!(arg7 > 0 || arg8 > 0, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v2);
        let v4 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg1);
        let v5 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf(arg1);
        let (v6, _, v8) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg5, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v0), v3, v4, v5, arg7, arg16);
        assert!(v6 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v0), 3);
        let (v9, _, v11) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg6, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg1, v1), v3, v4, v5, arg8, arg16);
        assert!(v9 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v1), 3);
        let (v12, v13) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_price_guarded(arg4, v3, v4, v5, arg16);
        assert!(v12 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg1, v2), 3);
        let v14 = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::safe_mul_div_u64(v8 + v11, 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::pow10((v3 as u8)), v13);
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg2, arg3, v14, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::tx_context::sender(arg17), v0, v1, arg7, arg8, arg16, arg17);
        (v2, v0, v1, v14)
    }

    public entry fun user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        impl_user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23);
    }

    fun user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: bool, arg22: 0x1::ascii::String, arg23: u64, arg24: u64, arg25: u64, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T3>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = get_coin_a_for_deposit_and_add_liquidity<T2, T3>(arg3, arg12, arg13, arg11, v0, v1);
        let v3 = 0x2::tx_context::sender(arg27);
        let v4 = 0;
        let v5 = if (v2 < v0) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(arg9, v3, arg27);
            v4 = v0 - v2;
            0x2::coin::split<T2>(&mut arg9, v2, arg27)
        } else {
            arg9
        };
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v9 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v8);
        let v10 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg2);
        let v11 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf(arg2);
        let v12 = v5;
        let (v13, v14, v15) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, &mut v12, &mut arg10, arg12, arg13, arg26, arg27);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T2>(v12, v3, arg27);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T3>(arg10, v3, arg27);
        let (v16, _, v18) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg7, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v6), v9, v10, v11, v14, arg26);
        assert!(v16 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v6), 3);
        let (v19, _, v21) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_amount_with_price_feed_guarded(arg8, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v7), v9, v10, v11, v15, arg26);
        assert!(v19 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v7), 3);
        let (v22, v23) = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::get_price_guarded(arg6, v9, v10, v11, arg26);
        assert!(v22 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v8), 3);
        let v24 = 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::safe_mul_div_u64(v18 + v21, 0xee61158dda590976951425962b7486e121af4888eead3f5eba248738fe6d7b6e::fast_price_feed::pow10((v9 as u8)), v23);
        if (arg21) {
            0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_vault_zapin_deposit<T0, T1>(arg0, arg4, arg5, v24, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v3, v6, v7, v14, v15, arg22, arg23, arg26, arg27);
            let v25 = UserZapInDepositAndAddLiquidity<T2, T3>{
                lp_id                   : v13,
                vault_id                : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4),
                pool_id                 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3),
                tick_lower              : arg12,
                tick_upper              : arg13,
                vault_token             : v8,
                token_a                 : v6,
                token_b                 : v7,
                input_amount_token_a    : v0,
                input_amount_token_b    : v1,
                refund_amount_token_a   : v4 + 0x2::coin::value<T2>(&v12),
                refund_amount_token_b   : 0x2::coin::value<T3>(&arg10),
                amount_token_a          : v14,
                amount_token_b          : v15,
                amount_deposit_to_vault : v24,
                token_deposit           : arg22,
                token_deposit_amount    : arg23,
                swap_amount_in          : arg24,
                swap_amount_out         : arg25,
            };
            0x2::event::emit<UserZapInDepositAndAddLiquidity<T2, T3>>(v25);
        } else {
            0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg4, arg5, v24, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v3, v6, v7, v14, v15, arg26, arg27);
            let v26 = UserDualDepositAndAddLiquidity<T2, T3>{
                lp_id                   : v13,
                vault_id                : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4),
                pool_id                 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3),
                tick_lower              : arg12,
                tick_upper              : arg13,
                vault_token             : v8,
                token_a                 : v6,
                token_b                 : v7,
                input_amount_token_a    : v0,
                input_amount_token_b    : v1,
                refund_amount_token_a   : v4 + 0x2::coin::value<T2>(&v12),
                refund_amount_token_b   : 0x2::coin::value<T3>(&arg10),
                amount_token_a          : v14,
                amount_token_b          : v15,
                amount_deposit_to_vault : v24,
            };
            0x2::event::emit<UserDualDepositAndAddLiquidity<T2, T3>>(v26);
        };
    }

    public fun user_deposit_and_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: u32, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        abort 0
    }

    public fun user_deposit_then_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
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
        let (v9, _, v11, v12) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg9);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
            if (v1 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T3>(arg0, arg4, arg5, arg10);
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
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_user_dual_deposit_addLiquidity_event<T2, T3>(v6, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T2>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
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
        let (v9, _, v11, v12) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_fund<T0, T1>(arg4, arg9, arg21);
            } else {
                0x2::coin::destroy_zero<T0>(arg9);
            };
            if (v1 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg10);
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
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_user_dual_deposit_addLiquidity_event<T0, T2>(v6, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T0>, arg11: u128, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: vector<vector<u8>>, arg18: vector<vector<u8>>, arg19: vector<u8>, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
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
        let (v9, _, v11, v12) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4));
        let v13 = v12;
        let v14 = v11;
        let v15 = v9;
        if (0x1::vector::length<0x2::object::ID>(&v15) != 1) {
            if (v0 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_harvest_assets<T0, T1, T2>(arg0, arg4, arg5, arg9);
            } else {
                0x2::coin::destroy_zero<T2>(arg9);
            };
            if (v1 > 0) {
                0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::vault_add_fund<T0, T1>(arg4, arg10, arg21);
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
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::emit_user_dual_deposit_addLiquidity_event<T2, T0>(v6, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg3), v7, v8, v23, v24, v25, v0, v1, v4, v5, v2, v3, v26);
    }

    public fun user_deposit_then_add_liquidity_v2<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg7: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        abort 0
    }

    public entry fun user_swap_coin_a_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun user_swap_coin_b_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg5: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T3>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

