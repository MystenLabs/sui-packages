module 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::clm {
    struct CLManagerCreated has copy, drop {
        clm_id: 0x2::object::ID,
        market_id: u64,
        llv_pool_id: 0x2::object::ID,
        admin: address,
        timestamp_ms: u64,
    }

    struct KeeperUpdated has copy, drop {
        clm_id: 0x2::object::ID,
        keeper: address,
        added: bool,
        timestamp_ms: u64,
    }

    struct AdminUpdated has copy, drop {
        clm_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
        timestamp_ms: u64,
    }

    struct CLManagerPauseUpdated has copy, drop {
        clm_id: 0x2::object::ID,
        paused: bool,
        timestamp_ms: u64,
    }

    struct CollateralSuppliedToLLV has copy, drop {
        clm_id: 0x2::object::ID,
        market_id: u64,
        llv_pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        llv_shares: u128,
        timestamp_ms: u64,
    }

    struct CollateralRecalledFromLLV has copy, drop {
        clm_id: 0x2::object::ID,
        market_id: u64,
        llv_pool_id: 0x2::object::ID,
        user: address,
        caller: address,
        shares_burned: u128,
        assets_received: u64,
        timestamp_ms: u64,
    }

    struct CLManager<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: u64,
        admin: address,
        keepers: vector<address>,
        llv_pool_id: 0x2::object::ID,
        clm_cap: 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::CLMCap,
        llv_position: 0x1::option::Option<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>,
        total_shares: u128,
        paused: bool,
    }

    public fun id<T0>(arg0: &CLManager<T0>) : 0x2::object::ID {
        0x2::object::id<CLManager<T0>>(arg0)
    }

    public entry fun add_keeper<T0>(arg0: &mut CLManager<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        assert!(!0x1::vector::contains<address>(&arg0.keepers, &arg1), 7);
        assert!(0x1::vector::length<address>(&arg0.keepers) < 20, 11);
        0x1::vector::push_back<address>(&mut arg0.keepers, arg1);
        let v0 = KeeperUpdated{
            clm_id       : 0x2::object::id<CLManager<T0>>(arg0),
            keeper       : arg1,
            added        : true,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<KeeperUpdated>(v0);
    }

    public fun admin<T0>(arg0: &CLManager<T0>) : address {
        arg0.admin
    }

    fun assert_keeper<T0>(arg0: &CLManager<T0>, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.keepers, &arg1), 2);
    }

    fun assert_not_paused<T0>(arg0: &CLManager<T0>) {
        assert!(!arg0.paused, 3);
    }

    fun assert_pool_match<T0>(arg0: &CLManager<T0>, arg1: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T0>) {
        assert!(0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::id<T0>(arg1) == arg0.llv_pool_id, 4);
    }

    public(friend) fun borrow_position<T0>(arg0: &CLManager<T0>) : &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0> {
        assert!(0x1::option::is_some<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position), 6);
        0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position)
    }

    public(friend) fun borrow_position_mut<T0>(arg0: &mut CLManager<T0>) : &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0> {
        assert!(0x1::option::is_some<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position), 6);
        0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&mut arg0.llv_position)
    }

    fun calculate_liquidation_recall_amount(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg0 as u128);
        if (arg1 <= v0) {
            return 0
        };
        let v1 = arg1 - v0;
        assert!(v1 <= 18446744073709551615, 12);
        (v1 as u64)
    }

    public entry fun create_clm<T0>(arg0: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg1: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::create_clm_cap(arg0, arg2, arg4);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::assert_clm_cap_market(&v0, arg2);
        let (v1, v2) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_market_llv_config(arg0, arg2);
        let v3 = v2;
        assert!(0x1::option::is_some<0x2::object::ID>(&v3) && v1 > 0, 10);
        let v4 = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::id<T0>(arg1);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v3) == v4, 4);
        let v5 = 0x2::tx_context::sender(arg4);
        let v6 = CLManager<T0>{
            id           : 0x2::object::new(arg4),
            market_id    : arg2,
            admin        : v5,
            keepers      : 0x1::vector::empty<address>(),
            llv_pool_id  : v4,
            clm_cap      : v0,
            llv_position : 0x1::option::none<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(),
            total_shares : 0,
            paused       : false,
        };
        let v7 = CLManagerCreated{
            clm_id       : 0x2::object::id<CLManager<T0>>(&v6),
            market_id    : arg2,
            llv_pool_id  : v4,
            admin        : v5,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CLManagerCreated>(v7);
        0x2::transfer::share_object<CLManager<T0>>(v6);
    }

    public(friend) fun ensure_position<T0>(arg0: &mut CLManager<T0>, arg1: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position)) {
            0x1::option::fill<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&mut arg0.llv_position, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::create_empty_position<T0>(arg1, arg2));
        };
    }

    public fun get_position_shares<T0>(arg0: &CLManager<T0>) : u128 {
        if (0x1::option::is_some<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position)) {
            0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::shares<T0>(0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T0>>(&arg0.llv_position))
        } else {
            0
        }
    }

    public fun is_keeper<T0>(arg0: &CLManager<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_paused<T0>(arg0: &CLManager<T0>) : bool {
        arg0.paused
    }

    public fun keepers<T0>(arg0: &CLManager<T0>) : &vector<address> {
        &arg0.keepers
    }

    public entry fun liquidate_with_recall<T0, T1, T2, T3>(arg0: &mut CLManager<T1>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T1>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>, arg5: address, arg6: u128, arg7: u128, arg8: 0x2::coin::Coin<T0>, arg9: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg10: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg11: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg12: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg13: u64, arg14: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg15: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg17: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg18: u8, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg21: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg22: &mut 0x3::sui_system::SuiSystemState, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert_pool_match<T1>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<T1>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_protocols_for_clm<T1>(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>>(arg4), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>>(arg12), arg13, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg15), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg16), arg18, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg17), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg19), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg20));
        let v0 = calculate_liquidation_recall_amount(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_collateral_reserve_balance<T1>(arg1, arg0.market_id), arg6);
        if (v0 > 0) {
            recall_collateral<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24);
        };
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_liquidation_entry::liquidate<T0, T1>(arg1, arg0.market_id, arg5, arg6, arg7, arg8, arg23, arg9, arg10, arg11, arg24);
    }

    public entry fun liquidate_with_recall_sui<T0, T1, T2, T3>(arg0: &mut CLManager<0x2::sui::SUI>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<0x2::sui::SUI>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>, arg5: address, arg6: u128, arg7: u128, arg8: 0x2::coin::Coin<T0>, arg9: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg10: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Farming, arg11: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::farming_core::Pool<T0>, arg12: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg13: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>, arg14: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg15: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg16: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg17: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg18: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg19: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg20: &mut 0x3::sui_system::SuiSystemState, arg21: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg22: u64, arg23: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg24: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg25: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg26: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg27: u8, arg28: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg29: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg30: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<0x2::sui::SUI>(arg0);
        assert_pool_match<0x2::sui::SUI>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<0x2::sui::SUI>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_all_protocols_for_clm(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>>(arg13), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg12), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg14), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg15), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg16), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg17), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg18), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg19), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg21), arg22, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg24), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg25), arg27, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg26), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg28), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg29));
        let v0 = calculate_liquidation_recall_amount(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_collateral_reserve_balance<0x2::sui::SUI>(arg1, arg0.market_id), arg6);
        if (v0 > 0) {
            recall_collateral_sui<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg9, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32);
        };
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_liquidation_entry::liquidate<T0, 0x2::sui::SUI>(arg1, arg0.market_id, arg5, arg6, arg7, arg8, arg31, arg9, arg10, arg11, arg32);
    }

    public fun llv_pool_id<T0>(arg0: &CLManager<T0>) : 0x2::object::ID {
        arg0.llv_pool_id
    }

    public fun market_id<T0>(arg0: &CLManager<T0>) : u64 {
        arg0.market_id
    }

    public entry fun pause<T0>(arg0: &mut CLManager<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.paused = true;
        let v0 = CLManagerPauseUpdated{
            clm_id       : 0x2::object::id<CLManager<T0>>(arg0),
            paused       : true,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CLManagerPauseUpdated>(v0);
    }

    public entry fun recall_collateral<T0, T1, T2, T3>(arg0: &mut CLManager<T1>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T1>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>, arg5: address, arg6: u64, arg7: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg8: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg9: u64, arg10: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg14: u8, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg17: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg18: &mut 0x3::sui_system::SuiSystemState, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert_pool_match<T1>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<T1>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_protocols_for_clm<T1>(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>>(arg4), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>>(arg8), arg9, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg11), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg12), arg14, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg13), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg15), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg16));
        let v0 = 0x2::tx_context::sender(arg20);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::sync_and_accrue_l1_l3<T1, T2, T3>(arg3, arg1, arg4, arg8, arg11, arg12, arg14, arg19);
        let (v1, v2) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_recall_from_llv<T0, T1>(&arg0.clm_cap, arg1, arg0.market_id, arg5, arg6, v0, &arg0.keepers, arg7, arg19, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<T1>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::get_total_assets<T1>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::total_shares<T1>(arg3), false);
        let (v3, v4, v5) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::withdraw_for_clm<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&mut arg0.llv_position), v2, arg1, arg4, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        arg0.total_shares = arg0.total_shares - v4;
        if (arg0.total_shares == 0 && 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::is_position_empty<T1>(0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&arg0.llv_position))) {
            0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::destroy_empty_position<T1>(0x1::option::extract<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&mut arg0.llv_position));
        };
        let v6 = CollateralRecalledFromLLV{
            clm_id          : 0x2::object::id<CLManager<T1>>(arg0),
            market_id       : arg0.market_id,
            llv_pool_id     : arg0.llv_pool_id,
            user            : arg5,
            caller          : v0,
            shares_burned   : v4,
            assets_received : (v5 as u64),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg19),
        };
        0x2::event::emit<CollateralRecalledFromLLV>(v6);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_recall_from_llv<T0, T1>(&arg0.clm_cap, arg1, v1, v3, v4, v0, arg7, arg19, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<T1>(arg3));
    }

    public entry fun recall_collateral_sui<T0, T1, T2, T3>(arg0: &mut CLManager<0x2::sui::SUI>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<0x2::sui::SUI>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>, arg5: address, arg6: u64, arg7: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg8: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg9: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>, arg10: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg11: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg12: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg13: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg14: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg15: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg16: &mut 0x3::sui_system::SuiSystemState, arg17: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg18: u64, arg19: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg20: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg23: u8, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg25: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg26: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg27: &0x2::clock::Clock, arg28: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<0x2::sui::SUI>(arg0);
        assert_pool_match<0x2::sui::SUI>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<0x2::sui::SUI>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_all_protocols_for_clm(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>>(arg9), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg8), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg10), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg11), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg12), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg13), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg14), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg15), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg17), arg18, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg20), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg21), arg23, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg22), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg24), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg25));
        let v0 = 0x2::tx_context::sender(arg28);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::sync_and_accrue_all<T1, T2, T3>(arg3, arg1, arg4, arg9, arg14, arg15, arg17, arg20, arg21, arg23, arg27);
        let (v1, v2) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_recall_from_llv<T0, 0x2::sui::SUI>(&arg0.clm_cap, arg1, arg0.market_id, arg5, arg6, v0, &arg0.keepers, arg7, arg27, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<0x2::sui::SUI>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::get_total_assets<0x2::sui::SUI>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::total_shares<0x2::sui::SUI>(arg3), false);
        let (v3, v4, v5) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::withdraw_for_clm_sui<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&mut arg0.llv_position), v2, arg1, arg4, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28);
        arg0.total_shares = arg0.total_shares - v4;
        if (arg0.total_shares == 0 && 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::is_position_empty<0x2::sui::SUI>(0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&arg0.llv_position))) {
            0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::destroy_empty_position<0x2::sui::SUI>(0x1::option::extract<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&mut arg0.llv_position));
        };
        let v6 = CollateralRecalledFromLLV{
            clm_id          : 0x2::object::id<CLManager<0x2::sui::SUI>>(arg0),
            market_id       : arg0.market_id,
            llv_pool_id     : arg0.llv_pool_id,
            user            : arg5,
            caller          : v0,
            shares_burned   : v4,
            assets_received : (v5 as u64),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg27),
        };
        0x2::event::emit<CollateralRecalledFromLLV>(v6);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_recall_from_llv<T0, 0x2::sui::SUI>(&arg0.clm_cap, arg1, v1, v3, v4, v0, arg7, arg27, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<0x2::sui::SUI>(arg3));
    }

    public entry fun remove_keeper<T0>(arg0: &mut CLManager<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.keepers, &arg1);
        assert!(v0, 8);
        0x1::vector::remove<address>(&mut arg0.keepers, v1);
        let v2 = KeeperUpdated{
            clm_id       : 0x2::object::id<CLManager<T0>>(arg0),
            keeper       : arg1,
            added        : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<KeeperUpdated>(v2);
    }

    public entry fun set_admin<T0>(arg0: &mut CLManager<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        arg0.admin = arg1;
        let v0 = AdminUpdated{
            clm_id       : 0x2::object::id<CLManager<T0>>(arg0),
            old_admin    : arg0.admin,
            new_admin    : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminUpdated>(v0);
    }

    public entry fun supply_collateral<T0, T1, T2, T3>(arg0: &mut CLManager<T1>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T1>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg8: u64, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert_pool_match<T1>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<T1>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_protocols_for_clm<T1>(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>>(arg4), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>>(arg7), arg8, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg10), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg11), arg13, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg12), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg14), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg15));
        let v0 = 0x2::tx_context::sender(arg17);
        let (v1, v2) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_route_to_llv<T0, T1>(&arg0.clm_cap, arg1, arg0.market_id, v0, arg5, arg6, arg16, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<T1>(arg3), arg17);
        let v3 = v2;
        let v4 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            let v5 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(v3);
            ensure_position<T1>(arg0, arg3, arg17);
            let (v6, _) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::deposit_for_clm<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&mut arg0.llv_position), v5, arg1, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
            arg0.total_shares = arg0.total_shares + v6;
            let v8 = CollateralSuppliedToLLV{
                clm_id       : 0x2::object::id<CLManager<T1>>(arg0),
                market_id    : arg0.market_id,
                llv_pool_id  : arg0.llv_pool_id,
                user         : v0,
                amount       : 0x2::coin::value<T1>(&v5),
                llv_shares   : v6,
                timestamp_ms : 0x2::clock::timestamp_ms(arg16),
            };
            0x2::event::emit<CollateralSuppliedToLLV>(v8);
            v6
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
            0
        };
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_route_to_llv<T1>(&arg0.clm_cap, arg1, v1, v4, arg16);
    }

    public entry fun supply_collateral_sui<T0, T1, T2, T3>(arg0: &mut CLManager<0x2::sui::SUI>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<0x2::sui::SUI>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg7: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg8: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg10: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg17: u64, arg18: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg19: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg22: u8, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &0x2::clock::Clock, arg26: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<0x2::sui::SUI>(arg0);
        assert_pool_match<0x2::sui::SUI>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<0x2::sui::SUI>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_all_protocols_for_clm(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>>(arg8), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg10), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg12), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg13), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg14), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg16), arg17, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg19), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg20), arg22, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg21), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg23), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg24));
        let v0 = 0x2::tx_context::sender(arg26);
        let (v1, v2) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_route_to_llv<T0, 0x2::sui::SUI>(&arg0.clm_cap, arg1, arg0.market_id, v0, arg5, arg6, arg25, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<0x2::sui::SUI>(arg3), arg26);
        let v3 = v2;
        let v4 = if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&v3)) {
            let v5 = 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(v3);
            ensure_position<0x2::sui::SUI>(arg0, arg3, arg26);
            let (v6, _) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::deposit_for_clm_sui<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&mut arg0.llv_position), v5, arg1, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
            arg0.total_shares = arg0.total_shares + v6;
            let v8 = CollateralSuppliedToLLV{
                clm_id       : 0x2::object::id<CLManager<0x2::sui::SUI>>(arg0),
                market_id    : arg0.market_id,
                llv_pool_id  : arg0.llv_pool_id,
                user         : v0,
                amount       : 0x2::coin::value<0x2::sui::SUI>(&v5),
                llv_shares   : v6,
                timestamp_ms : 0x2::clock::timestamp_ms(arg25),
            };
            0x2::event::emit<CollateralSuppliedToLLV>(v8);
            v6
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
            0
        };
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_route_to_llv<0x2::sui::SUI>(&arg0.clm_cap, arg1, v1, v4, arg25);
    }

    public fun total_shares<T0>(arg0: &CLManager<T0>) : u128 {
        arg0.total_shares
    }

    public entry fun unpause<T0>(arg0: &mut CLManager<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.paused = false;
        let v0 = CLManagerPauseUpdated{
            clm_id       : 0x2::object::id<CLManager<T0>>(arg0),
            paused       : false,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CLManagerPauseUpdated>(v0);
    }

    public entry fun withdraw_collateral<T0, T1, T2, T3>(arg0: &mut CLManager<T1>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<T1>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>, arg5: u64, arg6: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg8: u64, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg13: u8, arg14: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg15: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg16: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg17: &mut 0x3::sui_system::SuiSystemState, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T1>(arg0);
        assert_pool_match<T1>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<T1>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_protocols_for_clm<T1>(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<T1, T2>>(arg4), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>>(arg7), arg8, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg10), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg11), arg13, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg12), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg14), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg15));
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_collateral_reserve_balance<T1>(arg1, arg0.market_id);
        if (v1 < arg5) {
            if (0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_position_llv_shares(arg1, arg0.market_id, v0) > 0) {
                0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::sync_and_accrue_l1_l3<T1, T2, T3>(arg3, arg1, arg4, arg7, arg10, arg11, arg13, arg18);
                let (v2, v3) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_recall_from_llv<T0, T1>(&arg0.clm_cap, arg1, arg0.market_id, v0, arg5 - v1, v0, &arg0.keepers, arg6, arg18, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<T1>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::get_total_assets<T1>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::total_shares<T1>(arg3), true);
                let (v4, v5, v6) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::withdraw_for_clm<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&mut arg0.llv_position), v3, arg1, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
                arg0.total_shares = arg0.total_shares - v5;
                if (arg0.total_shares == 0 && 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::is_position_empty<T1>(0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&arg0.llv_position))) {
                    0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::destroy_empty_position<T1>(0x1::option::extract<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<T1>>(&mut arg0.llv_position));
                };
                let v7 = CollateralRecalledFromLLV{
                    clm_id          : 0x2::object::id<CLManager<T1>>(arg0),
                    market_id       : arg0.market_id,
                    llv_pool_id     : arg0.llv_pool_id,
                    user            : v0,
                    caller          : v0,
                    shares_burned   : v5,
                    assets_received : (v6 as u64),
                    timestamp_ms    : 0x2::clock::timestamp_ms(arg18),
                };
                0x2::event::emit<CollateralRecalledFromLLV>(v7);
                0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_recall_from_llv<T0, T1>(&arg0.clm_cap, arg1, v2, v4, v5, v0, arg6, arg18, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<T1>(arg3));
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_borrower_entry::withdraw_collateral_with_coin<T0, T1>(arg1, arg0.market_id, v0, (arg5 as u128), arg18, arg6, arg19), v0);
    }

    public entry fun withdraw_collateral_sui<T0, T1, T2, T3>(arg0: &mut CLManager<0x2::sui::SUI>, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg2: &0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_admin::LLVGlobal, arg3: &mut 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::LLVPool<0x2::sui::SUI>, arg4: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>, arg5: u64, arg6: &0xacc326fed15097da1b26c704ddb24b32f3bbe7496bd75dace9c249f61d9626b0::pyth_oracle::Oracle, arg7: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg8: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>, arg9: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg10: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg14: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg15: &mut 0x3::sui_system::SuiSystemState, arg16: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg17: u64, arg18: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg19: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg21: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg22: u8, arg23: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg25: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<0x2::sui::SUI>(arg0);
        assert_pool_match<0x2::sui::SUI>(arg0, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_for_clm<0x2::sui::SUI>(arg2, arg3);
        0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::validate_all_protocols_for_clm(arg3, 0x2::object::id<0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_core::Vault<0x2::sui::SUI, T1>>(arg4), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T3>>(arg8), 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager>(arg7), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager>(arg9), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig>(arg10), 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool>(arg11), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg12), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>>(arg13), 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg14), 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>>(arg16), arg17, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg19), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg20), arg22, 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>>(arg21), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg23), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg24));
        let v0 = 0x2::tx_context::sender(arg27);
        let v1 = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_collateral_reserve_balance<0x2::sui::SUI>(arg1, arg0.market_id);
        if (v1 < arg5) {
            if (0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::get_position_llv_shares(arg1, arg0.market_id, v0) > 0) {
                0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::sync_and_accrue_all<T1, T2, T3>(arg3, arg1, arg4, arg8, arg13, arg14, arg16, arg19, arg20, arg22, arg26);
                let (v2, v3) = 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::begin_recall_from_llv<T0, 0x2::sui::SUI>(&arg0.clm_cap, arg1, arg0.market_id, v0, arg5 - v1, v0, &arg0.keepers, arg6, arg26, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<0x2::sui::SUI>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::get_total_assets<0x2::sui::SUI>(arg3), 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_pool::total_shares<0x2::sui::SUI>(arg3), true);
                let (v4, v5, v6) = 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::withdraw_for_clm_sui<T1, T2, T3>(arg2, arg3, 0x1::option::borrow_mut<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&mut arg0.llv_position), v3, arg1, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
                arg0.total_shares = arg0.total_shares - v5;
                if (arg0.total_shares == 0 && 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::is_position_empty<0x2::sui::SUI>(0x1::option::borrow<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&arg0.llv_position))) {
                    0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::destroy_empty_position<0x2::sui::SUI>(0x1::option::extract<0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_position::LLVPoolPosition<0x2::sui::SUI>>(&mut arg0.llv_position));
                };
                let v7 = CollateralRecalledFromLLV{
                    clm_id          : 0x2::object::id<CLManager<0x2::sui::SUI>>(arg0),
                    market_id       : arg0.market_id,
                    llv_pool_id     : arg0.llv_pool_id,
                    user            : v0,
                    caller          : v0,
                    shares_burned   : v5,
                    assets_received : (v6 as u64),
                    timestamp_ms    : 0x2::clock::timestamp_ms(arg26),
                };
                0x2::event::emit<CollateralRecalledFromLLV>(v7);
                0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_clm::finish_recall_from_llv<T0, 0x2::sui::SUI>(&arg0.clm_cap, arg1, v2, v4, v5, v0, arg6, arg26, 0xbdff808bb3d65a93f396bcb3f2d3156a02e35dbbfd1d67190c0b3cf1f27ca672::llv_clm_adapter::get_share_price<0x2::sui::SUI>(arg3));
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market_borrower_entry::withdraw_collateral_with_coin<T0, 0x2::sui::SUI>(arg1, arg0.market_id, v0, (arg5 as u128), arg26, arg6, arg27), v0);
    }

    // decompiled from Move bytecode v6
}

