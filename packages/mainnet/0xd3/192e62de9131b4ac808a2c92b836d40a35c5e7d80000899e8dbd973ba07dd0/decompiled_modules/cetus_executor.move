module 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseAuthorityCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionKey has copy, drop, store {
        pool: 0x2::object::ID,
        owner: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct CetusConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        operators: 0x2::vec_map::VecMap<address, bool>,
        position_key_ids: 0x2::table::Table<PositionKey, 0x2::object::ID>,
        position_id_keys: 0x2::table::Table<0x2::object::ID, PositionKey>,
        position_nfts: 0x2::bag::Bag,
        access_cap: 0x1::option::Option<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>,
        pool_ids: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
        allow_all_pools: bool,
    }

    struct TableLpIdsByVaultId has store {
        tb: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
    }

    struct SwapEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        input_amount: u64,
        output_amount: u64,
    }

    struct OpenPositionEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct ClosePositionEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct AddLiquidityEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
        tick_lower: u32,
        tick_upper: u32,
        after_position_liquidity: u128,
        after_position_amount_token_a: u64,
        after_position_amount_token_b: u64,
    }

    struct RemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
        after_position_liquidity: u128,
        after_position_amount_token_a: u64,
        after_position_amount_token_b: u64,
    }

    struct CollectRewardEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        reward_token_type: 0x1::type_name::TypeName,
        reward_token_amount: u64,
    }

    struct CollectFeeEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        amount_token_a: u64,
        amount_token_b: u64,
    }

    struct ChangeAdminEvent has copy, drop, store {
        new_owner: address,
    }

    struct AddOperatorEvent has copy, drop, store {
        operator: address,
    }

    struct RemoveOperatorEvent has copy, drop, store {
        operator: address,
    }

    struct AddPoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct RemovePoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

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
        amount_a_fixed: u64,
        amount_b_fixed: u64,
    }

    struct UserDualDepositAndAddLiquidity<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x1::ascii::String,
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

    struct UserDualDepositAndAddLiquidityV2<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x1::ascii::String,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        vault_token: 0x1::ascii::String,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        input_amount_token_a: u64,
        input_amount_token_b: u64,
        deposit_fee_token_a: u64,
        deposit_fee_token_b: u64,
        refund_amount_token_a: u64,
        refund_amount_token_b: u64,
        amount_token_a: u64,
        amount_token_b: u64,
        amount_deposit_to_vault: u64,
    }

    struct PauseEvent has copy, drop {
        dummy_field: bool,
    }

    struct ResumeEvent has copy, drop {
        dummy_field: bool,
    }

    public entry fun swap<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_liquidity<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun close_position<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_fee<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_reward<T0, T1, T2, T3, T4>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun get_position_fee<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_fee<T0, T1>(arg0, arg1)
    }

    public fun get_position_reward<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : u64 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_reward<T0, T1, T2>(arg0, arg1)
    }

    public fun is_position_exist<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_position_exist<T0, T1>(arg0, arg1)
    }

    public entry fun open_position<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun remove_liquidity<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_access_cap(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public entry fun add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u128, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg12, arg13);
    }

    public entry fun add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u128, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg12, arg13);
    }

    entry fun add_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u128, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg12, arg13);
    }

    fun add_lp_id(arg0: &mut CetusConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v0 = TableLpIdsByVaultId{tb: 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg3)};
            0x2::dynamic_field::add<vector<u8>, TableLpIdsByVaultId>(&mut arg0.id, b"table_lp_ids", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableLpIdsByVaultId>(&mut arg0.id, b"table_lp_ids").tb;
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1);
            if (!0x1::vector::contains<0x2::object::ID>(v2, &arg2)) {
                0x1::vector::push_back<0x2::object::ID>(v2, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v3, arg2);
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1, v3);
        };
    }

    entry fun add_lp_ids(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: 0x2::object::ID, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"table_lp_ids")) {
            let v0 = TableLpIdsByVaultId{tb: 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg4)};
            0x2::dynamic_field::add<vector<u8>, TableLpIdsByVaultId>(&mut arg1.id, b"table_lp_ids", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableLpIdsByVaultId>(&mut arg1.id, b"table_lp_ids").tb;
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v1, arg2)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(v1, arg2);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
                let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v3);
                if (!0x1::vector::contains<0x2::object::ID>(v2, &v4)) {
                    0x1::vector::push_back<0x2::object::ID>(v2, v4);
                };
                v3 = v3 + 1;
            };
        } else {
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            let v6 = 0;
            while (v6 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
                let v7 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v6);
                if (!0x1::vector::contains<0x2::object::ID>(&v5, &v7)) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v5, v7);
                };
                v6 = v6 + 1;
            };
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(v1, arg2, v5);
        };
    }

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 5);
        0x2::vec_map::insert<address, bool>(&mut arg1.operators, arg2, true);
        let v0 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v0);
    }

    public entry fun add_pool_id(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &arg2), 10);
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.pool_ids, arg2, true);
        let v0 = AddPoolEvent{pool_id: arg2};
        0x2::event::emit<AddPoolEvent>(v0);
    }

    public entry fun add_pool_ids(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &v1)) {
                0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.pool_ids, v1, true);
                let v2 = AddPoolEvent{pool_id: v1};
                0x2::event::emit<AddPoolEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_contract_unpaused(arg0: &CetusConfig) {
        assert!(!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"contract_paused"), 13);
    }

    public fun assert_is_operator(arg0: &CetusConfig, arg1: address) {
        assert!(0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1), 4);
    }

    public fun assert_pool_exists(arg0: &CetusConfig, arg1: 0x2::object::ID) {
        assert!(arg0.allow_all_pools || 0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.pool_ids, &arg1), 11);
    }

    public fun assert_version(arg0: &CetusConfig) {
        assert!(arg0.version == 3, 7);
    }

    public(friend) fun borrow_access_cap(arg0: &CetusConfig, arg1: &0x2::tx_context::TxContext) : &0x1::option::Option<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap> {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg1));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        &arg0.access_cap
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / (10000 as u64)
    }

    public(friend) fun charge_deposit_fee<T0, T1, T2>(arg0: &CetusConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T2>) {
        if (arg4 == 0) {
            (0, arg3)
        } else {
            let v1 = calculate_fee(arg4, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_deposit_fee_bps<T0, T1>(arg1));
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::collect_fee_from_user<T0, T1, T2>(arg2, arg1, 0x2::coin::split<T2>(&mut arg3, v1, arg6), 0, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg5);
            (v1, arg3)
        }
    }

    public(friend) fun charge_deposit_fee_directly<T0, T1, T2>(arg0: &CetusConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock) {
        if (0x2::coin::value<T2>(&arg3) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::collect_fee_from_user<T0, T1, T2>(arg2, arg1, arg3, 0, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg4);
        } else {
            0x2::coin::destroy_zero<T2>(arg3);
        };
    }

    public(friend) fun check_limit_position(arg0: &CetusConfig, arg1: 0x2::object::ID) {
        let v0 = get_limit_position(arg0);
        if (v0 > 0) {
            let (v1, _) = get_vault_position_liquidities(arg0, arg1);
            let v3 = v1;
            assert!(0x1::vector::length<0x2::object::ID>(&v3) <= v0, 17);
        };
    }

    public entry fun check_pool<T0, T1>(arg0: &CetusConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
    }

    public(friend) fun check_time(arg0: &mut CetusConfig, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = get_submitted_time(arg0);
        let v1 = if (v0 > 20000) {
            v0 - 20000
        } else {
            v0
        };
        assert!(arg1 > v1, 14);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 15);
        set_submitted_time(arg0, arg1);
    }

    entry fun close_position_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v9 = 0x2::table::remove<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, arg7);
        assert!(v8 == v9.owner, 4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T2, T3>(arg1, arg2, 0x2::bag::remove<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_lp_by_id<T0, T1>(arg4, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), arg7, v7);
        let v10 = ClosePositionEvent<T2, T3>{
            vault_id   : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3),
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
            lp_id      : arg7,
            tick_lower : v9.tick_lower,
            tick_upper : v9.tick_upper,
        };
        0x2::event::emit<ClosePositionEvent<T2, T3>>(v10);
        0x2::table::remove<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v9);
        remove_lp_id(arg0, v8, arg7);
    }

    public entry fun collect_fee_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_fee_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let (v9, v10) = collect_fee_internal<T0, T2>(arg1, arg2, v8, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg7), arg7, arg11);
        let v11 = v10;
        let v12 = v9;
        if (0x2::coin::value<T0>(&v12) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v12, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v12);
        };
        if (0x2::coin::value<T2>(&v11) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v11, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v11);
        };
    }

    public entry fun collect_fee_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_fee_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let (v9, v10) = collect_fee_internal<T2, T0>(arg1, arg2, v8, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg7), arg7, arg11);
        let v11 = v10;
        let v12 = v9;
        if (0x2::coin::value<T2>(&v12) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v12, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v12);
        };
        if (0x2::coin::value<T0>(&v11) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v11, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v11);
        };
    }

    fun collect_fee_internal<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg0, arg1, arg3, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = CollectFeeEvent<T0, T1>{
            vault_id       : arg2,
            pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            lp_id          : arg4,
            amount_token_a : 0x2::balance::value<T0>(&v3),
            amount_token_b : 0x2::balance::value<T1>(&v2),
        };
        0x2::event::emit<CollectFeeEvent<T0, T1>>(v4);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::coin::from_balance<T1>(v2, arg5))
    }

    entry fun collect_fee_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let (v9, v10) = collect_fee_internal<T2, T3>(arg1, arg2, v8, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg7), arg7, arg11);
        let v11 = v10;
        let v12 = v9;
        if (0x2::coin::value<T2>(&v12) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v12, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v12);
        };
        if (0x2::coin::value<T3>(&v11) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v11, v7);
        } else {
            0x2::coin::destroy_zero<T3>(v11);
        };
    }

    public entry fun collect_reward_have_reward_in_vault<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_reward_have_reward_in_vault_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x2::object::ID, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg11);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault>(arg7);
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
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg9, arg10);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg8).owner, 4);
        let v9 = collect_reward_internal<T2, T3, T0>(arg1, arg2, v8, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg8), arg8, arg7, arg11, arg12);
        if (0x2::coin::value<T0>(&v9) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v9, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v9);
        };
    }

    fun collect_reward_internal<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: 0x2::object::ID, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg3, arg5, true, arg6);
        let v1 = CollectRewardEvent<T0, T1>{
            vault_id            : arg2,
            pool_id             : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            lp_id               : arg4,
            reward_token_type   : 0x1::type_name::get<T2>(),
            reward_token_amount : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<CollectRewardEvent<T0, T1>>(v1);
        0x2::coin::from_balance<T2>(v0, arg7)
    }

    entry fun collect_reward_with_auth<T0, T1, T2, T3, T4>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: 0x2::object::ID, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg11);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault>(arg7);
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
        0x1::vector::push_back<vector<u8>>(v7, 0x2::bcs::to_bytes<0x2::object::ID>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg9, arg10);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v9 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg8).owner, 4);
        let v10 = collect_reward_internal<T2, T3, T4>(arg1, arg2, v9, 0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg8), arg8, arg7, arg11, arg12);
        if (0x2::coin::value<T4>(&v10) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T4>(arg4, arg3, v10, v8);
        } else {
            0x2::coin::destroy_zero<T4>(v10);
        };
    }

    entry fun emergency_pause(arg0: &PauseAuthorityCap, arg1: &mut CetusConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = b"contract_paused";
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
            0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, v0, true);
            let v1 = PauseEvent{dummy_field: false};
            0x2::event::emit<PauseEvent>(v1);
        };
    }

    public(friend) fun emit_add_liquidity_record_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: vector<u8>, arg5: u64, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = AddLiquidityRecordEvent<T0, T1>{
            vault_id        : arg0,
            pool_id         : arg1,
            tick_lower      : arg2,
            tick_upper      : arg3,
            key_storage     : arg4,
            amount_in_vault : arg5,
            liquidity       : arg6,
            amount_a        : arg7,
            amount_b        : arg8,
            amount_a_fixed  : arg9,
            amount_b_fixed  : arg10,
        };
        0x2::event::emit<AddLiquidityRecordEvent<T0, T1>>(v0);
    }

    fun emit_event_add_liquidity<T0, T1>(arg0: &CetusConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u32, arg7: u32) {
        let (v0, v1) = get_position_amounts<T0, T1>(arg1, arg3);
        let v2 = AddLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            tick_lower                    : arg6,
            tick_upper                    : arg7,
            after_position_liquidity      : get_position_liquidity(arg0, arg3),
            after_position_amount_token_a : v0,
            after_position_amount_token_b : v1,
        };
        0x2::event::emit<AddLiquidityEvent<T0, T1>>(v2);
    }

    fun emit_event_remove_liquidity<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let (v0, v1) = get_position_amounts<T0, T1>(arg0, arg3);
        let v2 = RemoveLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            after_position_liquidity      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg1),
            after_position_amount_token_a : v0,
            after_position_amount_token_b : v1,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0, T1>>(v2);
    }

    public(friend) fun emit_swap_from_record_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: vector<u8>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = SwapFromRecordEvent<T0, T1>{
            vault_id               : arg0,
            pool_id                : arg1,
            direction              : arg2,
            key_storage            : arg3,
            restore                : arg4,
            amount_in_vault_before : arg5,
            swap_input_amount      : arg6,
            swap_output_amount     : arg7,
            amount_in_vault_after  : arg8,
        };
        0x2::event::emit<SwapFromRecordEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_swap_record_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = SwapRecordEvent<T0, T1>{
            vault_id           : arg0,
            pool_id            : arg1,
            direction          : arg2,
            key_storage        : arg3,
            input_amount       : arg4,
            swap_input_amount  : arg5,
            swap_output_amount : arg6,
            amount_in_vault    : arg7,
        };
        0x2::event::emit<SwapRecordEvent<T0, T1>>(v0);
    }

    public(friend) fun emit_user_dual_deposit_addLiquidity_event<T0, T1>(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64) {
        let v0 = UserDualDepositAndAddLiquidity<T0, T1>{
            lp_id                   : arg0,
            vault_id                : arg1,
            pool_id                 : arg2,
            tick_lower              : arg3,
            tick_upper              : arg4,
            vault_token             : arg5,
            token_a                 : arg6,
            token_b                 : arg7,
            input_amount_token_a    : arg8,
            input_amount_token_b    : arg9,
            refund_amount_token_a   : arg10,
            refund_amount_token_b   : arg11,
            amount_token_a          : arg12,
            amount_token_b          : arg13,
            amount_deposit_to_vault : arg14,
        };
        0x2::event::emit<UserDualDepositAndAddLiquidity<T0, T1>>(v0);
    }

    public(friend) fun emit_user_dual_deposit_addLiquidity_event_v2<T0, T1>(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: u32, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64) {
        let v0 = UserDualDepositAndAddLiquidityV2<T0, T1>{
            lp_id                   : arg0,
            vault_id                : arg1,
            pool_id                 : arg2,
            tick_lower              : arg3,
            tick_upper              : arg4,
            vault_token             : arg5,
            token_a                 : arg6,
            token_b                 : arg7,
            input_amount_token_a    : arg8,
            input_amount_token_b    : arg9,
            deposit_fee_token_a     : arg10,
            deposit_fee_token_b     : arg11,
            refund_amount_token_a   : arg12,
            refund_amount_token_b   : arg13,
            amount_token_a          : arg14,
            amount_token_b          : arg15,
            amount_deposit_to_vault : arg16,
        };
        0x2::event::emit<UserDualDepositAndAddLiquidityV2<T0, T1>>(v0);
    }

    public(friend) fun exec_add_liquidity<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        assert!(arg7 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T2, T3>(arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v0), arg7, arg8);
        let v2 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T3>(&v1);
        let v5 = if (v3 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, v3, v2, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v6 = if (v4 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T3>(arg6, arg5, v4, v2, arg9)
        } else {
            0x2::coin::zero<T3>(arg9)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T3>(arg1, arg2, 0x2::coin::into_balance<T2>(v5), 0x2::coin::into_balance<T3>(v6), v1);
        emit_event_add_liquidity<T2, T3>(arg0, arg2, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5), v0, v3, v4, arg3, arg4);
        (v3, v4)
    }

    public(friend) fun exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2));
        assert!(arg7 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T2>(arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v0), arg7, arg8);
        let v2 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T2>(&v1);
        let v5 = if (v3 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg6, arg5, v3, v2, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v6 = if (v4 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, v4, v2, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T2>(arg1, arg2, 0x2::coin::into_balance<T0>(v5), 0x2::coin::into_balance<T2>(v6), v1);
        emit_event_add_liquidity<T0, T2>(arg0, arg2, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5), v0, v3, v4, arg3, arg4);
        (v3, v4)
    }

    public(friend) fun exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2));
        assert!(arg7 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg9);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T2, T0>(arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v0), arg7, arg8);
        let v2 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T0>(&v1);
        let v5 = if (v3 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, v3, v2, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v6 = if (v4 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg6, arg5, v4, v2, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T0>(arg1, arg2, 0x2::coin::into_balance<T2>(v5), 0x2::coin::into_balance<T0>(v6), v1);
        emit_event_add_liquidity<T2, T0>(arg0, arg2, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5), v0, v3, v4, arg3, arg4);
        (v3, v4)
    }

    public(friend) fun exec_swap<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T3>(arg9)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T3>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T2>(arg9)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_a_in_vault_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v2, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2));
        assert!(arg6 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg5, arg4, arg6, v0, arg10)
        } else {
            0x2::coin::zero<T0>(arg10)
        };
        let v2 = v1;
        let v3 = if (arg8) {
            0x2::coin::zero<T2>(arg10)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg6, v0, arg10)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_a_in_vault_internal_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v5, v6, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg4, v2, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v4, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T0>(arg9)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_b_in_vault_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v4, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2));
        assert!(arg6 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg6, v0, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v2 = v1;
        let v3 = if (arg8) {
            0x2::coin::zero<T0>(arg10)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg5, arg4, arg6, v0, arg10)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_b_in_vault_internal_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, v5, v6, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg4, v4, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_with_partner<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: u64, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        assert!(arg6 > 0, 1);
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg8) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg5, arg4, arg6, v0, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v2 = v1;
        let v3 = if (arg8) {
            0x2::coin::zero<T3>(arg10)
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T3>(arg5, arg4, arg6, v0, arg10)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_internal_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v5, v6, arg6, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg5, arg4, v4, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_user_add_liquidity<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T3>, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64) {
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::coin::value<T2>(arg5);
        let v1 = 0x2::coin::value<T3>(arg6);
        assert!(v0 > 0 || v1 > 0, 3);
        let v2 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, false, arg10);
        let v3 = if (v0 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T3>(arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v2), v0, true, arg9)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T3>(arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v2), v1, false, arg9)
        };
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T3>(&v3);
        let v6 = if (v4 > 0) {
            assert!(0x2::coin::value<T2>(arg5) >= v4, 9);
            0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v4, arg10))
        } else {
            0x2::balance::zero<T2>()
        };
        let v7 = if (v5 > 0) {
            assert!(0x2::coin::value<T3>(arg6) >= v5, 9);
            0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg6, v5, arg10))
        } else {
            0x2::balance::zero<T3>()
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T3>(arg1, arg2, v6, v7, v3);
        emit_event_add_liquidity<T2, T3>(arg0, arg2, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3), v2, v4, v5, arg7, arg8);
        (v2, v4, v5)
    }

    public(friend) fun exec_user_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg6, true, arg4, arg5, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg6) {
            assert!(0x2::balance::value<T1>(&v4) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        };
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg6) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = if (arg6) {
            assert!(0x2::coin::value<T0>(&arg2) >= v6, 9);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg8)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg3) >= v6, 9);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg8)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg8));
        (v6, v7, arg2, arg3)
    }

    public(friend) fun exec_user_swap_with_partner<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg7, true, arg5, arg6, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg7) {
            assert!(0x2::balance::value<T1>(&v4) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        };
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg7) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = if (arg7) {
            assert!(0x2::coin::value<T0>(&arg3) >= v6, 9);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg9)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= v6, 9);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg9)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg9));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg9));
        (v6, v7, arg3, arg4)
    }

    public(friend) fun exec_vault_dual_deposit<T0, T1>(arg0: &CetusConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: address, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg17);
    }

    public(friend) fun exec_vault_zapin_deposit<T0, T1>(arg0: &CetusConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: address, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: u64, arg15: u64, arg16: 0x1::ascii::String, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_zap_mode_token<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg19);
    }

    public fun get_all_pool_from_position(arg0: &CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, u64) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, bool>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v1 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1)) {
                0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1);
                let v2 = 0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v1, arg1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x2::object::ID>(v2)) {
                    let v4 = 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, *0x1::vector::borrow<0x2::object::ID>(v2, v3)).pool;
                    if (!0x2::vec_map::contains<0x2::object::ID, bool>(&v0, &v4)) {
                        0x2::vec_map::insert<0x2::object::ID, bool>(&mut v0, v4, true);
                    };
                    v3 = v3 + 1;
                };
            };
        };
        (0x2::vec_map::keys<0x2::object::ID, bool>(&v0), 0x2::vec_map::length<0x2::object::ID, bool>(&v0))
    }

    public fun get_base_token_amount_from_positions<T0, T1>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID) : (u128, u128, vector<0x2::object::ID>) {
        0x1::vector::empty<0x2::object::ID>();
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v3 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v3, arg2)) {
                let v4 = *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v3, arg2);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
                    let v6 = *0x1::vector::borrow<0x2::object::ID>(&v4, v5);
                    let v7 = 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, v6);
                    if (0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == v7.pool) {
                        let (_, v9, v10) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::get_amount_token_from_liquidity(v7.tick_lower, v7.tick_upper, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, v6)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
                        v0 = v0 + v9;
                        v1 = v1 + v10;
                        0x1::vector::push_back<0x2::object::ID>(&mut v2, v6);
                    };
                    v5 = v5 + 1;
                };
            };
        };
        (v0, v1, v2)
    }

    public fun get_exactly_token_amount_from_positions<T0, T1>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::object::ID) : (u128, u128, vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0;
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v3 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v3, arg2)) {
                v0 = *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v3, arg2);
                let v4 = 0;
                while (v4 < 0x1::vector::length<0x2::object::ID>(&v0)) {
                    let v5 = *0x1::vector::borrow<0x2::object::ID>(&v0, v4);
                    let v6 = 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, v5);
                    assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == v6.pool, 16);
                    let (_, v8, v9) = 0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::get_amount_token_from_liquidity(v6.tick_lower, v6.tick_upper, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, v5)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1));
                    v1 = v1 + v8;
                    v2 = v2 + v9;
                    v4 = v4 + 1;
                };
            };
        };
        (v1, v2, v0)
    }

    public fun get_limit_position(arg0: &CetusConfig) : u64 {
        let v0 = b"limit_position";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun get_or_create_position<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg6: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2) = get_position_id<T0, T1, T2, T3>(arg0, arg2, arg5, arg3, arg4, arg8);
        let v3 = v1;
        let v4 = if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            if (arg7) {
                let v6 = OpenPositionEvent<T2, T3>{
                    vault_id   : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5),
                    pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
                    lp_id      : v5,
                    tick_lower : arg3,
                    tick_upper : arg4,
                };
                0x2::event::emit<OpenPositionEvent<T2, T3>>(v6);
            };
            v5
        } else {
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T3>(arg1, arg2, arg3, arg4, arg8);
            let v8 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7);
            0x2::bag::add<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, v8, v7);
            0x2::table::add<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v2, v8);
            0x2::table::add<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, v8, v2);
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_lp<T0, T1>(arg6, arg5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2), v8, v0);
            let v9 = OpenPositionEvent<T2, T3>{
                vault_id   : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5),
                pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
                lp_id      : v8,
                tick_lower : arg3,
                tick_upper : arg4,
            };
            0x2::event::emit<OpenPositionEvent<T2, T3>>(v9);
            v8
        };
        add_lp_id(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5), v4, arg8);
        check_limit_position(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg5));
        v4
    }

    public fun get_position_amounts<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        (0, 0)
    }

    fun get_position_id<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::object::ID>, PositionKey) {
        let v0 = PositionKey{
            pool       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
            owner      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            tick_lower : arg3,
            tick_upper : arg4,
        };
        let v1 = if (!0x2::table::contains<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PositionKey, 0x2::object::ID>(&arg0.position_key_ids, v0))
        };
        (v1, v0)
    }

    public fun get_position_liquidities(arg0: &CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x1::vector::push_back<u128>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1))));
            v1 = v1 + 1;
        };
        (arg1, v0)
    }

    public fun get_position_liquidity(arg0: &CetusConfig, arg1: 0x2::object::ID) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, arg1))
    }

    public fun get_submitted_time(arg0: &CetusConfig) : u64 {
        let v0 = b"submitted_time";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_swap_delta_bps(arg0: &CetusConfig) : u128 {
        let v0 = b"swap_delta_bps";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u128>(&arg0.id, v0)
        } else {
            100
        }
    }

    public fun get_vault_position_liquidities(arg0: &CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u128>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v2 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v2, arg1)) {
                v0 = *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v2, arg1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x2::object::ID>(&v0)) {
                    0x1::vector::push_back<u128>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, *0x1::vector::borrow<0x2::object::ID>(&v0, v3))));
                    v3 = v3 + 1;
                };
            };
        };
        (v0, v1)
    }

    public fun get_vault_position_value(arg0: &CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u128>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = 0x1::vector::empty<u32>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v4 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v4, arg1)) {
                v0 = *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v4, arg1);
                let v5 = 0;
                while (v5 < 0x1::vector::length<0x2::object::ID>(&v0)) {
                    let v6 = *0x1::vector::borrow<0x2::object::ID>(&v0, v5);
                    0x1::vector::push_back<u128>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position_nfts, v6)));
                    let v7 = 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, v6);
                    0x1::vector::push_back<u32>(&mut v2, v7.tick_lower);
                    0x1::vector::push_back<u32>(&mut v3, v7.tick_upper);
                    v5 = v5 + 1;
                };
            };
        };
        (v0, v1, v2, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = CetusConfig{
            id               : 0x2::object::new(arg0),
            version          : 3,
            operators        : 0x2::vec_map::empty<address, bool>(),
            position_key_ids : 0x2::table::new<PositionKey, 0x2::object::ID>(arg0),
            position_id_keys : 0x2::table::new<0x2::object::ID, PositionKey>(arg0),
            position_nfts    : 0x2::bag::new(arg0),
            access_cap       : 0x1::option::none<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(),
            pool_ids         : 0x2::vec_map::empty<0x2::object::ID, bool>(),
            allow_all_pools  : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<CetusConfig>(v1);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 3, 0);
        arg1.version = 3;
    }

    entry fun mint_pause_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PauseAuthorityCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<PauseAuthorityCap>(v0, arg1);
    }

    entry fun open_position_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg11);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u32>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, true, arg12);
    }

    public fun pool_exists<T0, T1>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : bool {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1);
        0x2::vec_map::contains<0x2::object::ID, bool>(&arg0.pool_ids, &v0)
    }

    public entry fun remove_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun remove_liquidity_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T2>(arg1, arg2, v9, v10, arg12);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x2::coin::from_balance<T0>(v14, arg13);
        let v16 = 0x2::coin::from_balance<T2>(v13, arg13);
        if (0x2::coin::value<T0>(&v15) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v15, arg13);
        } else {
            0x2::coin::destroy_zero<T0>(v15);
        };
        if (0x2::coin::value<T2>(&v16) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v16, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v16);
        };
        emit_event_remove_liquidity<T0, T2>(arg2, v9, v8, arg7, 0x2::balance::value<T0>(&v14), 0x2::balance::value<T2>(&v13));
    }

    public entry fun remove_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun remove_liquidity_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T2, T0>(arg1, arg2, v9, v10, arg12);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x2::coin::from_balance<T2>(v14, arg13);
        let v16 = 0x2::coin::from_balance<T0>(v13, arg13);
        if (0x2::coin::value<T2>(&v15) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v15, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v15);
        };
        if (0x2::coin::value<T0>(&v16) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, v16, arg13);
        } else {
            0x2::coin::destroy_zero<T0>(v16);
        };
        emit_event_remove_liquidity<T2, T0>(arg2, v9, v8, arg7, 0x2::balance::value<T2>(&v14), 0x2::balance::value<T0>(&v13));
    }

    entry fun remove_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<0x2::object::ID>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T2, T3>(arg1, arg2, v9, v10, arg12);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x2::coin::from_balance<T2>(v14, arg13);
        let v16 = 0x2::coin::from_balance<T3>(v13, arg13);
        if (0x2::coin::value<T2>(&v15) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v15, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v15);
        };
        if (0x2::coin::value<T3>(&v16) > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v16, v7);
        } else {
            0x2::coin::destroy_zero<T3>(v16);
        };
        emit_event_remove_liquidity<T2, T3>(arg2, v9, v8, arg7, 0x2::balance::value<T2>(&v14), 0x2::balance::value<T3>(&v13));
    }

    fun remove_lp_id(arg0: &mut CetusConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v0 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableLpIdsByVaultId>(&mut arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v0, arg1)) {
                let v1 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(v0, arg1);
                let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(v1, &arg2);
                if (v2) {
                    0x1::vector::swap_remove<0x2::object::ID>(v1, v3);
                };
            };
        };
    }

    entry fun remove_lp_ids(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: 0x2::object::ID, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"table_lp_ids")) {
            let v0 = TableLpIdsByVaultId{tb: 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg4)};
            0x2::dynamic_field::add<vector<u8>, TableLpIdsByVaultId>(&mut arg1.id, b"table_lp_ids", v0);
        };
        let v1 = &mut 0x2::dynamic_field::borrow_mut<vector<u8>, TableLpIdsByVaultId>(&mut arg1.id, b"table_lp_ids").tb;
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v1, arg2)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(v1, arg2);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
                let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v3);
                let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(v2, &v4);
                if (v5) {
                    0x1::vector::swap_remove<0x2::object::ID>(v2, v6);
                };
                v3 = v3 + 1;
            };
        };
    }

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, &arg2);
        let v2 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v2);
    }

    public entry fun remove_pool_id(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg1.pool_ids, &arg2);
        let v2 = RemovePoolEvent{pool_id: arg2};
        0x2::event::emit<RemovePoolEvent>(v2);
    }

    public entry fun remove_pool_ids(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.pool_ids, &v1)) {
                let (_, _) = 0x2::vec_map::remove<0x2::object::ID, bool>(&mut arg1.pool_ids, &v1);
                let v4 = RemovePoolEvent{pool_id: v1};
                0x2::event::emit<RemovePoolEvent>(v4);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_allow_all_pools(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.allow_all_pools = arg2;
    }

    entry fun set_contract_paused(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"contract_paused";
        if (arg2) {
            if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
                0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, v0, true);
                let v1 = PauseEvent{dummy_field: false};
                0x2::event::emit<PauseEvent>(v1);
            };
        } else if (0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, v0);
            let v2 = ResumeEvent{dummy_field: false};
            0x2::event::emit<ResumeEvent>(v2);
        };
    }

    entry fun set_limit_position(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"limit_position";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg1.id, v0, arg2);
        };
    }

    fun set_submitted_time(arg0: &mut CetusConfig, arg1: u64) {
        let v0 = b"submitted_time";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v0, arg1);
        };
    }

    entry fun set_swap_delta_bps(arg0: &AdminCap, arg1: &mut CetusConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0 && arg2 <= 10000, 12);
        let v0 = b"swap_delta_bps";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u128>(&mut arg1.id, v0, arg2);
        };
    }

    public(friend) fun split_deposit_fee_coin<T0, T1, T2>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T2>) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        if (v0 == 0) {
            (arg1, 0x2::coin::zero<T2>(arg2))
        } else {
            (arg1, 0x2::coin::split<T2>(&mut arg1, calculate_fee(v0, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_deposit_fee_bps<T0, T1>(arg0)), arg2))
        }
    }

    public entry fun swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun swap_have_coin_a_in_vault_internal<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T2>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg1, arg2, arg9, true, arg7, arg8, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T2>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T2>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T0>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, v7, arg11)), 0x2::balance::zero<T2>())
        } else {
            assert!(0x2::coin::value<T2>(arg6) >= v7, 9);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v7, arg11)))
        };
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v5, arg11));
        0x2::coin::join<T0>(arg5, 0x2::coin::from_balance<T0>(v6, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T0>(arg5);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg5, v11, arg11), arg11);
        };
        let v12 = 0x2::coin::value<T2>(arg6);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg6, v12, arg11), v0);
        };
        let v13 = SwapEvent<T0, T2>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T0, T2>>(v13);
        (v7, v8)
    }

    fun swap_have_coin_a_in_vault_internal_with_partner<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &mut 0x2::coin::Coin<T0>, arg7: &mut 0x2::coin::Coin<T2>, arg8: u64, arg9: u128, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T0, T2>(arg1, arg2, arg3, arg10, true, arg8, arg9, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg10) {
            assert!(0x2::balance::value<T2>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v4);
        let v8 = if (arg10) {
            0x2::balance::value<T2>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg8 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg10) {
            assert!(0x2::coin::value<T0>(arg6) >= v7, 9);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v7, arg12)), 0x2::balance::zero<T2>())
        } else {
            assert!(0x2::coin::value<T2>(arg7) >= v7, 9);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg7, v7, arg12)))
        };
        0x2::coin::join<T2>(arg7, 0x2::coin::from_balance<T2>(v5, arg12));
        0x2::coin::join<T0>(arg6, 0x2::coin::from_balance<T0>(v6, arg12));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T0, T2>(arg1, arg2, arg3, v9, v10, v4);
        let v11 = 0x2::coin::value<T0>(arg6);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg4, 0x2::coin::split<T0>(arg6, v11, arg12), arg12);
        };
        let v12 = 0x2::coin::value<T2>(arg7);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, 0x2::coin::split<T2>(arg7, v12, arg12), v0);
        };
        let v13 = SwapEvent<T0, T2>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2),
            direction     : arg10,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T0, T2>>(v13);
        (v7, v8)
    }

    entry fun swap_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    entry fun swap_have_coin_a_in_vault_with_auth_and_partner<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
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
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg11, arg12);
        let (_, _) = exec_swap_have_coin_a_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun swap_have_coin_b_in_vault_internal<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg1, arg2, arg9, true, arg7, arg8, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T0>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v7, arg11)), 0x2::balance::zero<T0>())
        } else {
            assert!(0x2::coin::value<T0>(arg6) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v7, arg11)))
        };
        0x2::coin::join<T0>(arg6, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg5);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v11, arg11), v0);
        };
        let v12 = 0x2::coin::value<T0>(arg6);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg6, v12, arg11), arg11);
        };
        let v13 = SwapEvent<T2, T0>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T0>>(v13);
        (v7, v8)
    }

    fun swap_have_coin_b_in_vault_internal_with_partner<T0, T1, T2>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T0>, arg8: u64, arg9: u128, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, T0>(arg1, arg2, arg3, arg10, true, arg8, arg9, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg10) {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v4);
        let v8 = if (arg10) {
            0x2::balance::value<T0>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg8 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg10) {
            assert!(0x2::coin::value<T2>(arg6) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v7, arg12)), 0x2::balance::zero<T0>())
        } else {
            assert!(0x2::coin::value<T0>(arg7) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg7, v7, arg12)))
        };
        0x2::coin::join<T0>(arg7, 0x2::coin::from_balance<T0>(v5, arg12));
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v6, arg12));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, T0>(arg1, arg2, arg3, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg6);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, 0x2::coin::split<T2>(arg6, v11, arg12), v0);
        };
        let v12 = 0x2::coin::value<T0>(arg7);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg4, 0x2::coin::split<T0>(arg7, v12, arg12), arg12);
        };
        let v13 = SwapEvent<T2, T0>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2),
            direction     : arg10,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T0>>(v13);
        (v7, v8)
    }

    entry fun swap_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    entry fun swap_have_coin_b_in_vault_with_auth_and_partner<T0, T1, T2>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
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
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg11, arg12);
        let (_, _) = exec_swap_have_coin_b_in_vault_with_partner<T0, T1, T2>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg13, arg14);
    }

    fun swap_internal<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T3>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T3>(arg1, arg2, arg9, true, arg7, arg8, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T3>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T3>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v7, arg11)), 0x2::balance::zero<T3>())
        } else {
            assert!(0x2::coin::value<T3>(arg6) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg6, v7, arg11)))
        };
        0x2::coin::join<T3>(arg6, 0x2::coin::from_balance<T3>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T3>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg5);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v11, arg11), v0);
        };
        let v12 = 0x2::coin::value<T3>(arg6);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, 0x2::coin::split<T3>(arg6, v12, arg11), v0);
        };
        let v13 = SwapEvent<T2, T3>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T3>>(v13);
        (v7, v8)
    }

    fun swap_internal_with_partner<T0, T1, T2, T3>(arg0: &CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg5: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg6: &mut 0x2::coin::Coin<T2>, arg7: &mut 0x2::coin::Coin<T3>, arg8: u64, arg9: u128, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap_with_partner<T2, T3>(arg1, arg2, arg3, arg10, true, arg8, arg9, arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg10) {
            assert!(0x2::balance::value<T3>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T3>(&v4);
        let v8 = if (arg10) {
            0x2::balance::value<T3>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0x96a0426b95bdeecca5d30a3164d1302d8de9a0aafc194543eb45cb0c2c6fab4::liquidity_math::adjust_for_slippage((arg8 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg10) {
            assert!(0x2::coin::value<T2>(arg6) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v7, arg12)), 0x2::balance::zero<T3>())
        } else {
            assert!(0x2::coin::value<T3>(arg7) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg7, v7, arg12)))
        };
        0x2::coin::join<T3>(arg7, 0x2::coin::from_balance<T3>(v5, arg12));
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v6, arg12));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap_with_partner<T2, T3>(arg1, arg2, arg3, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg6);
        if (v11 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg5, arg4, 0x2::coin::split<T2>(arg6, v11, arg12), v0);
        };
        let v12 = 0x2::coin::value<T3>(arg7);
        if (v12 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T3>(arg5, arg4, 0x2::coin::split<T3>(arg7, v12, arg12), v0);
        };
        let v13 = SwapEvent<T2, T3>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg4),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2),
            direction     : arg10,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T3>>(v13);
        (v7, v8)
    }

    entry fun swap_with_auth<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
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
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<u128>(&arg8));
        0x1::vector::push_back<vector<u8>>(v6, 0x2::bcs::to_bytes<bool>(&arg9));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    entry fun swap_with_auth_and_partner<T0, T1, T2, T3>(arg0: &mut CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg5: u64, arg6: u64, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: u64, arg9: u128, arg10: bool, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<CetusConfig>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg4);
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
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v6), arg11, arg12);
        let (_, _) = exec_swap_with_partner<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg3, arg4, arg8, arg9, arg10, arg13, arg14);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{new_owner: arg1};
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    public(friend) fun vault_add_fund<T0, T1>(arg0: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_fund<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) fun vault_add_harvest_assets<T0, T1, T2>(arg0: &CetusConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: 0x2::coin::Coin<T2>) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::add_harvest_assets<T0, T1, T2>(arg2, arg1, arg3, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap));
    }

    // decompiled from Move bytecode v6
}

