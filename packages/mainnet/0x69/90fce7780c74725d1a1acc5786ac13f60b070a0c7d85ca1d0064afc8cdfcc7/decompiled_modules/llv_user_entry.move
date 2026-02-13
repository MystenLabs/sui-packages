module 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_user_entry {
    struct WithdrawReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        shares_to_withdraw: u128,
        total_withdrawed: 0x2::balance::Balance<T0>,
        actual_withdraws: vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>,
    }

    struct DepositReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        min_shares_out: u128,
        remaining: 0x2::balance::Balance<T0>,
        actual_deposits: vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>,
        total_deposited: u128,
    }

    public fun get_min_deposit<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : u64 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_min_deposit<T0>(arg0)
    }

    public fun get_protocol_balance<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: u8) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_protocol_balance<T0>(arg0, arg1)
    }

    public fun get_protocol_ratio<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: u8) : u64 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_protocol_ratio<T0>(arg0, arg1)
    }

    public fun is_protocol_enabled<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: u8) : bool {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_protocol_enabled<T0>(arg0, arg1)
    }

    public fun deposit_to_cetus<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &mut DepositReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<0x2::sui::SUI>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<0x2::sui::SUI>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_CETUS(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_cetus_underlying<T0>(arg0, arg4, arg9, arg10), arg12);
        let v0 = (arg2 as u128);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::deposit_to_cetus<T0>(arg0, &mut arg1.remaining, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_deposits, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_CETUS(), v0));
        arg1.total_deposited = arg1.total_deposited + v0;
    }

    public fun deposit_to_navi<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut DepositReceipt<T0>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_navi_balance<T0>(arg0, arg3, arg5), arg8);
        let v0 = (arg2 as u128);
        let v1 = 0x1::vector::empty<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), v0));
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::deposit_to_navi<T0>(arg0, &mut arg1.remaining, &v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_deposits, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), v0));
        arg1.total_deposited = arg1.total_deposited + v0;
    }

    public fun deposit_to_scallop<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut DepositReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_scallop_balance<T0>(arg0, arg4), arg5);
        let v0 = (arg2 as u128);
        let v1 = 0x1::vector::empty<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), v0));
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::deposit_to_scallop<T0>(arg0, &mut arg1.remaining, &v1, arg3, arg4, arg5, arg6);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_deposits, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), v0));
        arg1.total_deposited = arg1.total_deposited + v0;
    }

    public fun deposit_to_suilend<T0, T1>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut DepositReceipt<T0>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_suilend_balance<T0, T1>(arg0, arg3), arg5);
        let v0 = (arg2 as u128);
        let v1 = 0x1::vector::empty<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>();
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut v1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), v0));
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::deposit_to_suilend<T0, T1>(arg0, &mut arg1.remaining, &v1, arg3, arg4, arg5, arg6);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_deposits, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), v0));
        arg1.total_deposited = arg1.total_deposited + v0;
    }

    public fun deposit_to_vault<T0, T1>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut DepositReceipt<T0>, arg2: u64, arg3: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_VAULT(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_vault_underlying<T0, T1>(arg0, arg4, arg3), arg5);
        let v0 = (arg2 as u128);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::deposit_to_vault<T0, T1>(arg0, &mut arg1.remaining, v0, arg3, arg4, arg5, arg6);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_deposits, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_VAULT(), v0));
        arg1.total_deposited = arg1.total_deposited + v0;
    }

    public fun withdraw_from_cetus<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<0x2::sui::SUI>, arg1: &mut WithdrawReceipt<0x2::sui::SUI>, arg2: u64, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg10: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<0x2::sui::SUI>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<0x2::sui::SUI>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_CETUS(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_cetus_underlying<T0>(arg0, arg4, arg9, arg10), arg12);
        let (v0, _, v2) = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::withdraw_from_cetus<T0>(arg0, (arg2 as u128), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.total_withdrawed, v0);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_withdraws, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_CETUS(), v2));
    }

    public fun withdraw_from_navi<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut WithdrawReceipt<T0>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_navi_balance<T0>(arg0, arg3, arg5), arg10);
        let (v0, v1) = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::withdraw_from_navi<T0>(arg0, (arg2 as u128), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::balance::join<T0>(&mut arg1.total_withdrawed, v0);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_withdraws, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), v1));
    }

    public fun withdraw_from_scallop<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut WithdrawReceipt<T0>, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_scallop_balance<T0>(arg0, arg4), arg5);
        let (v0, v1) = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::withdraw_from_scallop<T0>(arg0, (arg2 as u128), arg3, arg4, arg5, arg6);
        0x2::balance::join<T0>(&mut arg1.total_withdrawed, v0);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_withdraws, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), v1));
    }

    public fun withdraw_from_suilend<T0, T1>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut WithdrawReceipt<T0>, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_suilend_balance<T0, T1>(arg0, arg3), arg5);
        let (v0, v1) = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::withdraw_from_suilend<T0, T1>(arg0, (arg2 as u128), arg3, arg4, arg5, arg6);
        0x2::balance::join<T0>(&mut arg1.total_withdrawed, v0);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_withdraws, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), v1));
    }

    public fun withdraw_from_vault<T0, T1>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &mut WithdrawReceipt<T0>, arg2: u64, arg3: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg4: &mut 0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_VAULT(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_vault_underlying<T0, T1>(arg0, arg4, arg3), arg5);
        let (v0, v1) = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::withdraw_from_vault<T0, T1>(arg0, (arg2 as u128), arg3, arg4, arg5, arg6);
        0x2::balance::join<T0>(&mut arg1.total_withdrawed, v0);
        0x1::vector::push_back<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(&mut arg1.actual_withdraws, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::create(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_VAULT(), v1));
    }

    public fun begin_deposit<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u128) : DepositReceipt<T0> {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 2);
        DepositReceipt<T0>{
            pool_id         : 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg1),
            min_shares_out  : arg3,
            remaining       : 0x2::coin::into_balance<T0>(arg2),
            actual_deposits : 0x1::vector::empty<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(),
            total_deposited : 0,
        }
    }

    public fun begin_withdraw<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg3: u128) : WithdrawReceipt<T0> {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        assert!(arg3 > 0, 2);
        assert!(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::pool_id<T0>(arg2) == 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::id<T0>(arg1), 7);
        assert!(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::shares<T0>(arg2) >= arg3, 9);
        WithdrawReceipt<T0>{
            pool_id            : 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg1),
            shares_to_withdraw : arg3,
            total_withdrawed   : 0x2::balance::zero<T0>(),
            actual_withdraws   : 0x1::vector::empty<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>(),
        }
    }

    public fun complete_deposit<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: DepositReceipt<T0>, arg2: 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let DepositReceipt {
            pool_id         : v0,
            min_shares_out  : v1,
            remaining       : v2,
            actual_deposits : v3,
            total_deposited : v4,
        } = arg1;
        let v5 = v3;
        let v6 = v2;
        assert!(v0 == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        let v7 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg0);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg0, v7, 0x2::clock::timestamp_ms(arg3));
        let v8 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::calculate_shares_for_amount<T0>(arg0, v4);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::verify_min_shares(v8, v1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::assert_deposit_cap<T0>(arg0, v7, (v4 as u64));
        let v9 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::build_deposit_result(v8, &v5);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::record_deposit_state<T0>(arg0, &v9, &v5);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::add_to_position<T0>(arg0, &mut arg2, v8, v4);
        if (0x2::balance::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_events::emit_deposited(v0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::id<T0>(&arg2), 0x2::tx_context::sender(arg4), (v4 as u64), v8, v5, 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::public_transfer<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun complete_withdraw<T0>(arg0: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg2: WithdrawReceipt<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let WithdrawReceipt {
            pool_id            : v0,
            shares_to_withdraw : v1,
            total_withdrawed   : v2,
            actual_withdraws   : v3,
        } = arg2;
        let v4 = v3;
        let v5 = v2;
        assert!(v0 == 0x2::object::id<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>>(arg0), 8);
        let v6 = 0x2::balance::value<T0>(&v5);
        assert!((v6 as u128) >= (arg3 as u128), 4);
        let v7 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg0) + (v6 as u128);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg0, v7, 0x2::clock::timestamp_ms(arg4));
        let v8 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_math::calculate_assets_for_shares(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::total_shares<T0>(arg0), v7, v1);
        let v9 = if ((v6 as u128) >= v8) {
            v1
        } else {
            0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_math::mul_div(v1, (v6 as u128), v8)
        };
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::record_withdraw_state<T0>(arg0, v9, &v4);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_events::emit_withdrawn(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::id<T0>(arg0), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::id<T0>(&arg1), 0x2::tx_context::sender(arg5), v9, v6, v4, 0x2::clock::timestamp_ms(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg5), 0x2::tx_context::sender(arg5));
        if (0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::deduct_from_position<T0>(arg0, &mut arg1, v9, (v6 as u128)) == 0) {
            0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::destroy_empty_position<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public fun create_empty_position<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0> {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::create<T0>(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::id<T0>(arg1), 0, 0, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::global_yield_index<T0>(arg1), arg2)
    }

    public fun destroy_empty_position<T0>(arg0: 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::destroy_empty_position<T0>(arg0);
    }

    public fun estimate_position_profit<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : (u128, bool) {
        let v0 = estimate_position_value<T0>(arg0, arg1);
        let v1 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::deposited_assets<T0>(arg1);
        if (v0 >= v1) {
            (v0 - v1, true)
        } else {
            (v1 - v0, false)
        }
    }

    public fun estimate_position_value<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_math::calculate_assets_for_shares(0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::total_shares<T0>(arg0), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg0), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::shares<T0>(arg1))
    }

    public fun is_pool_paused<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : bool {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg0)
    }

    public fun is_position_empty<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : bool {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::is_empty<T0>(arg0)
    }

    public fun is_position_in_pool<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : bool {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::pool_id<T0>(arg0) == 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::id<T0>(arg1)
    }

    public fun pool_total_assets<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg0)
    }

    public fun pool_total_shares<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::total_shares<T0>(arg0)
    }

    public fun pool_yield_index<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::global_yield_index<T0>(arg0)
    }

    public fun position_deposited_assets<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::deposited_assets<T0>(arg0)
    }

    public fun position_pool_id<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : 0x2::object::ID {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::pool_id<T0>(arg0)
    }

    public fun position_shares<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : u128 {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::shares<T0>(arg0)
    }

    public fun preview_deposit<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: u64) : (u128, vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::calculate_deposit<T0>(arg0, arg1);
        (0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::shares_to_mint(&v0), *0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_deposit::allocation(&v0))
    }

    public fun preview_withdraw_all<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>) : (u128, u128, vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::calculate_withdraw_all<T0>(arg0, arg1);
        (0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::shares_to_burn(&v0), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::assets_to_receive(&v0), *0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_assets<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg2: u64) : (u128, vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::calculate_withdraw_by_assets<T0>(arg0, arg1, arg2);
        (0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::shares_to_burn(&v0), *0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::recall_plan(&v0))
    }

    public fun preview_withdraw_by_shares<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg1: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_position::LLVPoolPosition<T0>, arg2: u128) : (u128, vector<0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::ProtocolAmount>) {
        let v0 = 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::calculate_withdraw_by_shares<T0>(arg0, arg1, arg2);
        (0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::assets_to_receive(&v0), *0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_withdraw::recall_plan(&v0))
    }

    public entry fun sync_and_accrue_cetus_only<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<0x2::sui::SUI>, arg2: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<0x2::sui::SUI>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<0x2::sui::SUI>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_CETUS(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_cetus_underlying<T0>(arg1, arg2, arg3, arg4), arg5);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<0x2::sui::SUI>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<0x2::sui::SUI>(arg1), 0x2::clock::timestamp_ms(arg5));
    }

    public entry fun sync_and_accrue_navi_only<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &0x2::clock::Clock) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_NAVI(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_navi_balance<T0>(arg1, arg2, arg3), arg4);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun sync_and_accrue_scallop_only<T0>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SCALLOP(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_scallop_balance<T0>(arg1, arg2), arg3);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun sync_and_accrue_suilend_only<T0, T1>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &0x2::clock::Clock) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_SUILEND(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_suilend_balance<T0, T1>(arg1, arg2), arg3);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun sync_and_accrue_vault_only<T0, T1>(arg0: &0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::LLVGlobal, arg1: &mut 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::LLVPool<T0>, arg2: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::market::Hearn, arg3: &0x11de8ffeb1c7e283d62a77ce49dbe7802c81cc332d9d42a5facf16fd770ac0a3::meta_vault_core::Vault<T0, T1>, arg4: &0x2::clock::Clock) {
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::assert_version(arg0);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_admin::is_global_paused(arg0), 5);
        assert!(!0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::is_paused<T0>(arg1), 1);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_sync::sync_protocol_balance<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_allocation_plan::PROTOCOL_VAULT(), 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_protocol_ops::query_vault_underlying<T0, T1>(arg1, arg3, arg2), arg4);
        0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::accrue_fees<T0>(arg1, 0x6990fce7780c74725d1a1acc5786ac13f60b070a0c7d85ca1d0064afc8cdfcc7::llv_pool::get_total_assets<T0>(arg1), 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

