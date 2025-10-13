module 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PositionKey has copy, drop, store {
        pool: 0x2::object::ID,
        owner: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct BluefinExecutorConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        operators: 0x2::vec_map::VecMap<address, bool>,
        position_key_ids: 0x2::table::Table<PositionKey, 0x2::object::ID>,
        position_id_keys: 0x2::table::Table<0x2::object::ID, PositionKey>,
        position_nfts: 0x2::bag::Bag,
        access_cap: 0x1::option::Option<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>,
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

    public entry fun swap<T0, T1, T2, T3>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_fee<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_reward<T0, T1, T2, T3, T4>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun open_position<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u32, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun remove_liquidity<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_access_cap(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public entry fun add_liquidity<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        let (_, _) = exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg10, arg13, arg14);
    }

    public entry fun add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun add_liquidity_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        let (_, _) = exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg10, arg13, arg14);
    }

    entry fun add_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg13);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg11, arg12);
        let (_, _) = exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, arg9, arg10, arg13, arg14);
    }

    fun add_lp_id(arg0: &mut BluefinExecutorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
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

    entry fun add_lp_ids(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: 0x2::object::ID, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
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

    public entry fun add_operator(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 5);
        0x2::vec_map::insert<address, bool>(&mut arg1.operators, arg2, true);
        let v0 = AddOperatorEvent{operator: arg2};
        0x2::event::emit<AddOperatorEvent>(v0);
    }

    public entry fun add_pool_id(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg1.id, arg2), 10);
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg1.id, arg2, true);
        let v0 = AddPoolEvent{pool_id: arg2};
        0x2::event::emit<AddPoolEvent>(v0);
    }

    public entry fun add_pool_ids(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (!0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg1.id, v1)) {
                0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg1.id, v1, true);
                let v2 = AddPoolEvent{pool_id: v1};
                0x2::event::emit<AddPoolEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_contract_unpaused(arg0: &BluefinExecutorConfig) {
        assert!(!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"contract_paused"), 13);
    }

    public fun assert_is_operator(arg0: &BluefinExecutorConfig, arg1: address) {
        assert!(0x2::vec_map::contains<address, bool>(&arg0.operators, &arg1), 4);
    }

    public fun assert_pool_exists(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg0.id, b"allow_all_pools") || 0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg0.id, arg1), 11);
    }

    public fun assert_version(arg0: &BluefinExecutorConfig) {
        assert!(arg0.version == 1, 7);
    }

    public(friend) fun borrow_access_cap(arg0: &BluefinExecutorConfig, arg1: &0x2::tx_context::TxContext) : &0x1::option::Option<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap> {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg1));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        &arg0.access_cap
    }

    public entry fun check_pool<T0, T1>(arg0: &BluefinExecutorConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1));
    }

    public(friend) fun check_time(arg0: &mut BluefinExecutorConfig, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1 >= get_submitted_time(arg0), 14);
        assert!(v0 >= arg1 - 2000 && v0 <= arg1 + 2000, 14);
        assert!(v0 <= arg2, 14);
        set_submitted_time(arg0, arg1);
    }

    public entry fun close_position<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun close_position_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v9 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v10 = 0x2::table::remove<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, arg7);
        assert!(v8 == v10.owner, 4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T2, T3>(arg10, arg1, arg2, 0x2::bag::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7));
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::withdraw_lp_by_id<T0, T1>(arg4, arg3, v9, arg7, v7);
        let v11 = ClosePositionEvent<T2, T3>{
            vault_id   : v8,
            pool_id    : v9,
            lp_id      : arg7,
            tick_lower : v10.tick_lower,
            tick_upper : v10.tick_upper,
        };
        0x2::event::emit<ClosePositionEvent<T2, T3>>(v11);
        0x2::table::remove<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v10);
        remove_lp_id(arg0, v8, arg7);
    }

    public entry fun collect_fee_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_fee_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let (v10, v11) = collect_fee_internal<T0, T2>(arg1, arg2, v8, v9, arg7, arg10, arg11);
        let v12 = v11;
        let v13 = v10;
        if (0x2::coin::value<T0>(&v13) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, v13, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v13);
        };
        if (0x2::coin::value<T2>(&v12) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v12, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v12);
        };
    }

    public entry fun collect_fee_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_fee_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let (v10, v11) = collect_fee_internal<T2, T0>(arg1, arg2, v8, v9, arg7, arg10, arg11);
        let v12 = v11;
        let v13 = v10;
        if (0x2::coin::value<T2>(&v13) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v13, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v13);
        };
        if (0x2::coin::value<T0>(&v12) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, v12, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v12);
        };
    }

    fun collect_fee_internal<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg0, arg1, arg3);
        let v4 = CollectFeeEvent<T0, T1>{
            vault_id       : arg2,
            pool_id        : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1),
            lp_id          : arg4,
            amount_token_a : v0,
            amount_token_b : v1,
        };
        0x2::event::emit<CollectFeeEvent<T0, T1>>(v4);
        (0x2::coin::from_balance<T0>(v2, arg6), 0x2::coin::from_balance<T1>(v3, arg6))
    }

    entry fun collect_fee_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let (v10, v11) = collect_fee_internal<T2, T3>(arg1, arg2, v8, v9, arg7, arg10, arg11);
        let v12 = v11;
        let v13 = v10;
        if (0x2::coin::value<T2>(&v13) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v13, v7);
        } else {
            0x2::coin::destroy_zero<T2>(v13);
        };
        if (0x2::coin::value<T3>(&v12) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v12, v7);
        } else {
            0x2::coin::destroy_zero<T3>(v12);
        };
    }

    public entry fun collect_reward_have_reward_in_vault<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun collect_reward_have_reward_in_vault_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v7 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v8 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let v9 = collect_reward_internal<T2, T3, T0>(arg1, arg2, v7, v8, arg7, arg10, arg11);
        if (0x2::coin::value<T0>(&v9) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, v9, arg11);
        } else {
            0x2::coin::destroy_zero<T0>(v9);
        };
    }

    fun collect_reward_internal<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg5, arg0, arg1, arg3);
        let v1 = CollectRewardEvent<T0, T1>{
            vault_id            : arg2,
            pool_id             : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1),
            lp_id               : arg4,
            reward_token_type   : 0x1::type_name::get<T2>(),
            reward_token_amount : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<CollectRewardEvent<T0, T1>>(v1);
        0x2::coin::from_balance<T2>(v0, arg6)
    }

    entry fun collect_reward_with_auth<T0, T1, T2, T3, T4>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg10);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg11));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg8, arg9);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = collect_reward_internal<T2, T3, T4>(arg1, arg2, v8, v9, arg7, arg10, arg11);
        if (0x2::coin::value<T4>(&v10) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T4>(arg4, arg3, v10, v7);
        } else {
            0x2::coin::destroy_zero<T4>(v10);
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

    fun emit_event_add_liquidity<T0, T1>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u32, arg7: u32) {
        let (v0, v1) = get_position_amounts(arg0, arg3);
        let v2 = AddLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1),
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

    fun emit_event_remove_liquidity<T0, T1>(arg0: 0x2::object::ID, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = RemoveLiquidityEvent<T0, T1>{
            vault_id                      : arg2,
            pool_id                       : arg0,
            lp_id                         : arg3,
            amount_token_a                : arg4,
            amount_token_b                : arg5,
            after_position_liquidity      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg1),
            after_position_amount_token_a : 0,
            after_position_amount_token_b : 0,
        };
        0x2::event::emit<RemoveLiquidityEvent<T0, T1>>(v0);
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

    public(friend) fun exec_add_liquidity<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg10);
        let v1 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg7 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg7, v1, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v3 = if (arg8 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T3>(arg6, arg5, arg8, v1, arg10)
        } else {
            0x2::coin::zero<T3>(arg10)
        };
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T3>(arg9, arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, v0), 0x2::coin::into_balance<T2>(v2), 0x2::coin::into_balance<T3>(v3), arg7, true);
        let v8 = v7;
        let v9 = v6;
        if (0x2::balance::value<T2>(&v9) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, 0x2::coin::from_balance<T2>(v9, arg10), v1);
        } else {
            0x2::balance::destroy_zero<T2>(v9);
        };
        if (0x2::balance::value<T3>(&v8) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T3>(arg6, arg5, 0x2::coin::from_balance<T3>(v8, arg10), v1);
        } else {
            0x2::balance::destroy_zero<T3>(v8);
        };
        emit_event_add_liquidity<T2, T3>(arg0, arg2, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5), v0, v4, v5, arg3, arg4);
        (v4, v5)
    }

    public(friend) fun exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2));
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg10);
        let v1 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg7 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_vault_funds<T0, T1>(arg6, arg5, arg7, v1, arg10)
        } else {
            0x2::coin::zero<T0>(arg10)
        };
        let v3 = if (arg8 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg8, v1, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg9, arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, v0), 0x2::coin::into_balance<T0>(v2), 0x2::coin::into_balance<T2>(v3), arg7, true);
        let v8 = v7;
        let v9 = v6;
        if (0x2::balance::value<T0>(&v9) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg5, 0x2::coin::from_balance<T0>(v9, arg10), arg10);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        if (0x2::balance::value<T2>(&v8) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, 0x2::coin::from_balance<T2>(v8, arg10), v1);
        } else {
            0x2::balance::destroy_zero<T2>(v8);
        };
        emit_event_add_liquidity<T0, T2>(arg0, arg2, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5), v0, v4, v5, arg3, arg4);
        (v4, v5)
    }

    public(friend) fun exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg10));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2));
        assert!(arg7 > 0 || arg8 > 0, 3);
        let v0 = get_or_create_position<T0, T1, T2, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg10);
        let v1 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v2 = if (arg7 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg6, arg5, arg7, v1, arg10)
        } else {
            0x2::coin::zero<T2>(arg10)
        };
        let v3 = if (arg8 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_vault_funds<T0, T1>(arg6, arg5, arg8, v1, arg10)
        } else {
            0x2::coin::zero<T0>(arg10)
        };
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T0>(arg9, arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, v0), 0x2::coin::into_balance<T2>(v2), 0x2::coin::into_balance<T0>(v3), arg7, true);
        let v8 = v7;
        let v9 = v6;
        if (0x2::balance::value<T2>(&v9) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg6, arg5, 0x2::coin::from_balance<T2>(v9, arg10), v1);
        } else {
            0x2::balance::destroy_zero<T2>(v9);
        };
        if (0x2::balance::value<T0>(&v8) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg5, 0x2::coin::from_balance<T0>(v8, arg10), arg10);
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
        emit_event_add_liquidity<T2, T0>(arg0, arg2, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5), v0, v4, v5, arg3, arg4);
        (v4, v5)
    }

    public(friend) fun exec_swap<T0, T1, T2, T3>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T3>(arg9)
        } else {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T3>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T3>(&v4) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T3>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T2>(arg9)
        } else {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_a_in_vault_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, v2, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        if (0x2::coin::value<T2>(&v4) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v4, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_is_operator(arg0, 0x2::tx_context::sender(arg9));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2));
        assert!(arg5 > 0, 1);
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v1 = if (arg7) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_harvest_asset<T0, T1, T2>(arg4, arg3, arg5, v0, arg9)
        } else {
            0x2::coin::zero<T2>(arg9)
        };
        let v2 = v1;
        let v3 = if (arg7) {
            0x2::coin::zero<T0>(arg9)
        } else {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::spend_vault_funds<T0, T1>(arg4, arg3, arg5, v0, arg9)
        };
        let v4 = v3;
        let v5 = &mut v2;
        let v6 = &mut v4;
        let (v7, v8) = swap_have_coin_b_in_vault_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v5, v6, arg5, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<T2>(&v2) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, v2, v0);
        } else {
            0x2::coin::destroy_zero<T2>(v2);
        };
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, v4, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        (v7, v8)
    }

    public(friend) fun exec_user_add_liquidity<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::coin::value<T2>(&arg5);
        assert!(v0 > 0 || 0x2::coin::value<T3>(&arg6) > 0, 3);
        let v1 = get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, false, arg10);
        let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T3>(arg9, arg1, arg2, 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, v1), 0x2::coin::into_balance<T2>(arg5), 0x2::coin::into_balance<T3>(arg6), v0, true);
        emit_event_add_liquidity<T2, T3>(arg0, arg2, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3), v1, v2, v3, arg7, arg8);
        (v1, v2, v3, 0x2::coin::from_balance<T2>(v4, arg10), 0x2::coin::from_balance<T3>(v5, arg10))
    }

    public(friend) fun exec_user_swap<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg7, arg0, arg1, arg6, true, arg4, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg6) {
            assert!(0x2::balance::value<T1>(&v4) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        };
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
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
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg8));
        (v6, v7, arg2, arg3)
    }

    public(friend) fun exec_vault_dual_deposit<T0, T1>(arg0: &BluefinExecutorConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg2: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: address, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::deposit_dual_token<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap), arg17);
    }

    public(friend) fun exec_vault_zapin_deposit<T0, T1>(arg0: &BluefinExecutorConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg2: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: address, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: u64, arg15: u64, arg16: 0x1::ascii::String, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::deposit_zap_mode_token<T0, T1>(arg2, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap), arg19);
    }

    fun get_or_create_position<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: u32, arg4: u32, arg5: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg6: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2) = get_position_id<T0, T1, T2, T3>(arg0, arg2, arg5, arg3, arg4, arg8);
        let v3 = v1;
        let v4 = if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            if (arg7) {
                let v6 = OpenPositionEvent<T2, T3>{
                    vault_id   : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5),
                    pool_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
                    lp_id      : v5,
                    tick_lower : arg3,
                    tick_upper : arg4,
                };
                0x2::event::emit<OpenPositionEvent<T2, T3>>(v6);
            };
            v5
        } else {
            let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T2, T3>(arg1, arg2, arg3, arg4, arg8);
            let v8 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v7);
            0x2::bag::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, v8, v7);
            0x2::table::add<PositionKey, 0x2::object::ID>(&mut arg0.position_key_ids, v2, v8);
            0x2::table::add<0x2::object::ID, PositionKey>(&mut arg0.position_id_keys, v8, v2);
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_lp<T0, T1>(arg6, arg5, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2), v8, v0);
            let v9 = OpenPositionEvent<T2, T3>{
                vault_id   : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5),
                pool_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
                lp_id      : v8,
                tick_lower : arg3,
                tick_upper : arg4,
            };
            0x2::event::emit<OpenPositionEvent<T2, T3>>(v9);
            v8
        };
        add_lp_id(arg0, 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg5), v4, arg8);
        v4
    }

    public fun get_position_amounts(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) : (u64, u64) {
        (0, 0)
    }

    fun get_position_id<T0, T1, T2, T3>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg2: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::object::ID>, PositionKey) {
        let v0 = PositionKey{
            pool       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg1),
            owner      : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg2),
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

    public fun get_position_liquidities(arg0: &BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x1::vector::push_back<u128>(&mut v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nfts, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1))));
            v1 = v1 + 1;
        };
        (arg1, v0)
    }

    public fun get_position_liquidity(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) : u128 {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nfts, arg1))
    }

    public fun get_submitted_time(arg0: &BluefinExecutorConfig) : u64 {
        let v0 = b"submitted_time";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun get_swap_delta_bps(arg0: &BluefinExecutorConfig) : u128 {
        let v0 = b"swap_delta_bps";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u128>(&arg0.id, v0)
        } else {
            100
        }
    }

    public fun get_vault_position_liquidities(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u128>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"table_lp_ids")) {
            let v2 = &0x2::dynamic_field::borrow<vector<u8>, TableLpIdsByVaultId>(&arg0.id, b"table_lp_ids").tb;
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(v2, arg1)) {
                v0 = *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(v2, arg1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<0x2::object::ID>(&v0)) {
                    0x1::vector::push_back<u128>(&mut v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nfts, *0x1::vector::borrow<0x2::object::ID>(&v0, v3))));
                    v3 = v3 + 1;
                };
            };
        };
        (v0, v1)
    }

    public fun get_vault_position_value(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
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
                    0x1::vector::push_back<u128>(&mut v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x2::bag::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position_nfts, v6)));
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
        let v1 = BluefinExecutorConfig{
            id               : 0x2::object::new(arg0),
            version          : 1,
            operators        : 0x2::vec_map::empty<address, bool>(),
            position_key_ids : 0x2::table::new<PositionKey, 0x2::object::ID>(arg0),
            position_id_keys : 0x2::table::new<0x2::object::ID, PositionKey>(arg0),
            position_nfts    : 0x2::bag::new(arg0),
            access_cap       : 0x1::option::none<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BluefinExecutorConfig>(v1);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    entry fun open_position_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg11);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg12));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg9, arg10);
        get_or_create_position<T0, T1, T2, T3>(arg0, arg1, arg2, arg7, arg8, arg3, arg4, true, arg12);
    }

    public fun pool_exists(arg0: &BluefinExecutorConfig, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg0.id, arg1)
    }

    public entry fun remove_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun remove_liquidity_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T2>(arg1, arg2, v9, v10, arg12);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, 0x2::coin::from_balance<T0>(v13, arg13), arg13);
        } else {
            0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(v13, arg13));
        };
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::from_balance<T2>(v14, arg13), v7);
        } else {
            0x2::coin::destroy_zero<T2>(0x2::coin::from_balance<T2>(v14, arg13));
        };
        emit_event_remove_liquidity<T0, T2>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2), v9, v8, arg7, v11, v12);
    }

    public entry fun remove_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: 0x2::object::ID, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun remove_liquidity_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T2, T0>(arg1, arg2, v9, v10, arg12);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::from_balance<T2>(v13, arg13), v7);
        } else {
            0x2::coin::destroy_zero<T2>(0x2::coin::from_balance<T2>(v13, arg13));
        };
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, 0x2::coin::from_balance<T0>(v14, arg13), arg13);
        } else {
            0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(v14, arg13));
        };
        emit_event_remove_liquidity<T2, T0>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2), v9, v8, arg7, v11, v12);
    }

    entry fun remove_liquidity_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        assert_is_operator(arg0, 0x2::tx_context::sender(arg13));
        assert_version(arg0);
        assert_contract_unpaused(arg0);
        assert_pool_exists(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2));
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let v7 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let v8 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        assert!(v8 == 0x2::table::borrow<0x2::object::ID, PositionKey>(&arg0.position_id_keys, arg7).owner, 4);
        let v9 = 0x2::bag::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position_nfts, arg7);
        let v10 = if (arg9) {
            assert!(arg8 == 0, 8);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v9)
        } else {
            assert!(arg8 > 0, 3);
            arg8
        };
        if (v10 == 0) {
            return
        };
        let (v11, v12, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T2, T3>(arg1, arg2, v9, v10, arg12);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::from_balance<T2>(v13, arg13), v7);
        } else {
            0x2::coin::destroy_zero<T2>(0x2::coin::from_balance<T2>(v13, arg13));
        };
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, 0x2::coin::from_balance<T3>(v14, arg13), v7);
        } else {
            0x2::coin::destroy_zero<T3>(0x2::coin::from_balance<T3>(v14, arg13));
        };
        emit_event_remove_liquidity<T2, T3>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2), v9, v8, arg7, v11, v12);
    }

    fun remove_lp_id(arg0: &mut BluefinExecutorConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
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

    entry fun remove_lp_ids(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: 0x2::object::ID, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
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

    public entry fun remove_operator(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.operators, &arg2), 6);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.operators, &arg2);
        let v2 = RemoveOperatorEvent{operator: arg2};
        0x2::event::emit<RemoveOperatorEvent>(v2);
    }

    public entry fun remove_pool_id(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg1.id, arg2), 11);
        0x2::dynamic_field::remove<0x2::object::ID, bool>(&mut arg1.id, arg2);
        let v0 = RemovePoolEvent{pool_id: arg2};
        0x2::event::emit<RemovePoolEvent>(v0);
    }

    public entry fun remove_pool_ids(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            if (0x2::dynamic_field::exists_with_type<0x2::object::ID, bool>(&arg1.id, v1)) {
                0x2::dynamic_field::remove<0x2::object::ID, bool>(&mut arg1.id, v1);
                let v2 = RemovePoolEvent{pool_id: v1};
                0x2::event::emit<RemovePoolEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_allow_all_pools(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"allow_all_pools";
        if (arg2) {
            if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
                0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, v0, true);
            };
        } else if (0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, v0);
        };
    }

    entry fun set_contract_paused(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"contract_paused";
        if (arg2) {
            if (!0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
                0x2::dynamic_field::add<vector<u8>, bool>(&mut arg1.id, v0, true);
            };
        } else if (0x2::dynamic_field::exists_with_type<vector<u8>, bool>(&arg1.id, v0)) {
            0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg1.id, v0);
        };
    }

    fun set_submitted_time(arg0: &mut BluefinExecutorConfig, arg1: u64) {
        let v0 = b"submitted_time";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v0, arg1);
        };
    }

    entry fun set_swap_delta_bps(arg0: &AdminCap, arg1: &mut BluefinExecutorConfig, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0 && arg2 <= 10000, 12);
        let v0 = b"swap_delta_bps";
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u128>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u128>(&mut arg1.id, v0, arg2);
        };
    }

    public entry fun swap_have_coin_a_in_vault<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun swap_have_coin_a_in_vault_internal<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::coin::Coin<T2>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T2>(arg10, arg1, arg2, arg9, true, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T2>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v6) > 0, 2);
        };
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T2>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T2>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T0>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, v7, arg11)), 0x2::balance::zero<T2>())
        } else {
            assert!(0x2::coin::value<T2>(arg6) >= v7, 9);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg6, v7, arg11)))
        };
        0x2::coin::join<T2>(arg6, 0x2::coin::from_balance<T2>(v5, arg11));
        0x2::coin::join<T0>(arg5, 0x2::coin::from_balance<T0>(v6, arg11));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T2>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T0>(arg5);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg5, v11, arg11), arg11);
        };
        let v12 = 0x2::coin::value<T2>(arg6);
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg6, v12, arg11), v0);
        };
        let v13 = SwapEvent<T0, T2>{
            vault_id      : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T0, T2>>(v13);
        (v7, v8)
    }

    entry fun swap_have_coin_a_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun swap_have_coin_b_in_vault<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun swap_have_coin_b_in_vault_internal<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T0>(arg10, arg1, arg2, arg9, true, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T0>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T0>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v7, arg11)), 0x2::balance::zero<T0>())
        } else {
            assert!(0x2::coin::value<T0>(arg6) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v7, arg11)))
        };
        0x2::coin::join<T0>(arg6, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T0>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg5);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v11, arg11), v0);
        };
        let v12 = 0x2::coin::value<T0>(arg6);
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg3, 0x2::coin::split<T0>(arg6, v12, arg11), arg11);
        };
        let v13 = SwapEvent<T2, T0>{
            vault_id      : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T0>>(v13);
        (v7, v8)
    }

    entry fun swap_have_coin_b_in_vault_with_auth<T0, T1, T2>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    fun swap_internal<T0, T1, T2, T3>(arg0: &BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: &mut 0x2::coin::Coin<T2>, arg6: &mut 0x2::coin::Coin<T3>, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T2, T3>(arg10, arg1, arg2, arg9, true, arg7, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg9) {
            assert!(0x2::balance::value<T3>(&v5) > 0, 2);
        } else {
            assert!(0x2::balance::value<T2>(&v6) > 0, 2);
        };
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T2, T3>(&v4);
        let v8 = if (arg9) {
            0x2::balance::value<T3>(&v5)
        } else {
            0x2::balance::value<T2>(&v6)
        };
        assert!(v7 >= (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((arg7 as u128), get_swap_delta_bps(arg0), 10000, false) as u64), 1);
        let (v9, v10) = if (arg9) {
            assert!(0x2::coin::value<T2>(arg5) >= v7, 9);
            (0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg5, v7, arg11)), 0x2::balance::zero<T3>())
        } else {
            assert!(0x2::coin::value<T3>(arg6) >= v7, 9);
            (0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(arg6, v7, arg11)))
        };
        0x2::coin::join<T3>(arg6, 0x2::coin::from_balance<T3>(v5, arg11));
        0x2::coin::join<T2>(arg5, 0x2::coin::from_balance<T2>(v6, arg11));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T2, T3>(arg1, arg2, v9, v10, v4);
        let v11 = 0x2::coin::value<T2>(arg5);
        if (v11 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg4, arg3, 0x2::coin::split<T2>(arg5, v11, arg11), v0);
        };
        let v12 = 0x2::coin::value<T3>(arg6);
        if (v12 > 0) {
            0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T3>(arg4, arg3, 0x2::coin::split<T3>(arg6, v12, arg11), v0);
        };
        let v13 = SwapEvent<T2, T3>{
            vault_id      : 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3),
            pool_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            direction     : arg9,
            input_amount  : v7,
            output_amount : v8,
        };
        0x2::event::emit<SwapEvent<T2, T3>>(v13);
        (v7, v8)
    }

    entry fun swap_with_auth<T0, T1, T2, T3>(arg0: &mut BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        check_time(arg0, arg5, arg6, arg12);
        let v0 = 0x2::object::id<BluefinExecutorConfig>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg1);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2);
        let v3 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>>(arg3);
        let v4 = 0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig>(arg4);
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
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::verify_signature(arg4, 0x1::vector::flatten<u8>(v5), arg10, arg11);
        let (_, _) = exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg12, arg13);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = ChangeAdminEvent{new_owner: arg1};
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    public(friend) fun vault_add_fund<T0, T1>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_fund<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) fun vault_add_harvest_assets<T0, T1, T2>(arg0: &BluefinExecutorConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg2: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg3: 0x2::coin::Coin<T2>) {
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::add_harvest_assets<T0, T1, T2>(arg2, arg1, arg3, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(&arg0.access_cap));
    }

    // decompiled from Move bytecode v6
}

