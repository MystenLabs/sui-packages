module 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::scallop_market_vault {
    struct ScallopMarketVault<phantom T0: drop, phantom T1: drop, phantom T2: drop, phantom T3: drop> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        market_coin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        updated_at: u64,
        withdraw_window_ms: u64,
        withdraw_bps_per_window: u64,
        withdraw_window_start_ms: u64,
        withdraw_window_base_reserve: u64,
        withdraw_window_withdrawn: u64,
        withdraw_window_minted: u64,
        queued_market_coin: u64,
        withdraw_queue: vector<0x2::object::ID>,
    }

    struct WithdrawRequest<phantom T0: drop, phantom T1: drop, phantom T2: drop, phantom T3: drop> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        owner: address,
        underlying_value: u64,
        market_coin_amount: u64,
        created_at: u64,
        sy_balance: 0x2::balance::Balance<T1>,
    }

    struct MarketVaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        created_by: address,
    }

    struct DepositEvent has copy, drop {
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        underlying_value_in: u64,
        market_coin_in: u64,
        market_coin_change_out: u64,
        depositor: address,
    }

    struct RedeemEvent has copy, drop {
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        underlying_value_out: u64,
        market_coin_out: u64,
        redeemer: address,
    }

    struct WithdrawCircuitBreakerUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        withdraw_window_ms: u64,
        withdraw_bps_per_window: u64,
        window_start_ms: u64,
        window_base_reserve: u64,
        updater: address,
    }

    struct WithdrawWindowRolledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        window_start_ms: u64,
        window_base_reserve: u64,
    }

    struct WithdrawQueuedEvent has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        owner: address,
        underlying_value: u64,
        market_coin_amount: u64,
        created_at: u64,
    }

    struct WithdrawCancelledEvent has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        owner: address,
        underlying_value: u64,
        market_coin_amount: u64,
        sy_amount: u64,
        cancelled_at: u64,
    }

    struct WithdrawCompletedEvent has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        owner: address,
        underlying_value: u64,
        market_coin_amount: u64,
        completed_at: u64,
        operator: address,
    }

    struct WithdrawRejectedEvent has copy, drop {
        request_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        owner: address,
        underlying_value: u64,
        market_coin_amount: u64,
        sy_amount: u64,
        rejected_at: u64,
        operator: address,
    }

    fun assert_market_match<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>) {
        assert!(arg0.market_id == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::id<T1, T2, T3>(arg1), 1002);
    }

    fun assert_request_matches_vault<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(arg1 == 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg0), 1010);
        assert!(arg2 == arg0.market_id, 1010);
        assert!(arg3 == arg0.scallop_market_id, 1010);
    }

    public(friend) fun assert_scallop_market_match<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(arg0.scallop_market_id == 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1), 1005);
    }

    fun assert_withdraw_circuit_breaker_config(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 1007);
        assert!(arg1 > 0 && arg1 <= 10000, 1008);
    }

    public fun cancel_queued_redeem<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: WithdrawRequest<T0, T1, T2, T3>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut ScallopMarketVault<T0, T1, T2, T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        let WithdrawRequest {
            id                 : v0,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            created_at         : _,
            sy_balance         : v8,
        } = arg0;
        let v9 = v8;
        let v10 = v0;
        let v11 = 0x2::object::uid_to_inner(&v10);
        assert_request_matches_vault<T0, T1, T2, T3>(arg2, v1, v2, v3);
        assert!(v4 == 0x2::tx_context::sender(arg4), 1011);
        assert!(arg2.queued_market_coin >= v6, 1012);
        remove_queued_request_id<T0, T1, T2, T3>(arg2, v11);
        arg2.queued_market_coin = arg2.queued_market_coin - v6;
        let v12 = 0x2::clock::timestamp_ms(arg3);
        arg2.updated_at = v12;
        let v13 = WithdrawCancelledEvent{
            request_id         : v11,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            sy_amount          : 0x2::balance::value<T1>(&v9),
            cancelled_at       : v12,
        };
        0x2::event::emit<WithdrawCancelledEvent>(v13);
        0x2::object::delete(v10);
        0x2::coin::from_balance<T1>(v9, arg4)
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 13906838533735186431);
        (v0 as u64)
    }

    fun complete_queued_redeem<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: WithdrawRequest<T0, T1, T2, T3>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::SyState, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &mut ScallopMarketVault<T0, T1, T2, T3>, arg4: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3>(arg3, arg4);
        let WithdrawRequest {
            id                 : v0,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            created_at         : _,
            sy_balance         : v8,
        } = arg0;
        let v9 = v0;
        let v10 = 0x2::object::uid_to_inner(&v9);
        assert_request_matches_vault<T0, T1, T2, T3>(arg3, v1, v2, v3);
        assert!(arg3.queued_market_coin >= v6, 1012);
        remove_queued_request_id<T0, T1, T2, T3>(arg3, v10);
        arg3.queued_market_coin = arg3.queued_market_coin - v6;
        arg3.updated_at = 0x2::clock::timestamp_ms(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg3.market_coin_balance, v6), arg6), v4);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::burn_escrowed_sy<T1, T2, T3, 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::SCALLOP>(0x2::coin::from_balance<T1>(v8, arg6), 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::sign(), arg1, arg2, arg4);
        let v11 = WithdrawCompletedEvent{
            request_id         : v10,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            completed_at       : arg3.updated_at,
            operator           : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<WithdrawCompletedEvent>(v11);
        0x2::object::delete(v9);
    }

    public fun complete_queued_redeem_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: WithdrawRequest<T0, T1, T2, T3>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::SyState, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &mut ScallopMarketVault<T0, T1, T2, T3>, arg5: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg7), 0x1::string::utf8(b"scallop_adapter.complete_withdraw"));
        complete_queued_redeem<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun complete_queued_redeem_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: WithdrawRequest<T0, T1, T2, T3>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::SyState, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &mut ScallopMarketVault<T0, T1, T2, T3>, arg5: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        complete_queued_redeem<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun consume_withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut ScallopMarketVault<T0, T1, T2, T3>, arg1: u64) {
        assert!(arg1 <= remaining_quota<T0, T1, T2, T3>(arg0), 1009);
        arg0.withdraw_window_withdrawn = checked_add_u64(arg0.withdraw_window_withdrawn, arg1);
    }

    fun create_market_vault<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_withdraw_circuit_breaker_config(arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = ScallopMarketVault<T0, T1, T2, T3>{
            id                           : 0x2::object::new(arg5),
            market_id                    : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::id<T1, T2, T3>(arg0),
            scallop_market_id            : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg1),
            market_coin_balance          : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            updated_at                   : v0,
            withdraw_window_ms           : arg2,
            withdraw_bps_per_window      : arg3,
            withdraw_window_start_ms     : v0,
            withdraw_window_base_reserve : 0,
            withdraw_window_withdrawn    : 0,
            withdraw_window_minted       : 0,
            queued_market_coin           : 0,
            withdraw_queue               : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v2 = MarketVaultCreatedEvent{
            vault_id          : 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(&v1),
            market_id         : v1.market_id,
            scallop_market_id : v1.scallop_market_id,
            created_by        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketVaultCreatedEvent>(v2);
        0x2::transfer::share_object<ScallopMarketVault<T0, T1, T2, T3>>(v1);
    }

    public fun create_market_vault_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"scallop_adapter.create_market"));
        create_market_vault<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_market_vault_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        create_market_vault<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public(friend) fun current_sy_index<T0: drop>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u128 {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), 0x1::type_name::with_defining_ids<T0>()));
        assert!(v3 > 0, 1101);
        assert!(v0 + v1 >= v2, 1100);
        let v4 = ((v0 + v1 - v2) as u128) * 18446744073709551616 / (v3 as u128);
        assert!(v4 > 0, 1102);
        v4
    }

    public fun deposit<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::MintSyRequest<T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: u64, arg3: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::SyState, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg5: &mut ScallopMarketVault<T0, T1, T2, T3>, arg6: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg7: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg8: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        assert_market_match<T0, T1, T2, T3>(arg5, arg6);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::get_mint_request_market_id<T1>(&arg0) == arg5.market_id, 1002);
        assert_scallop_market_match<T0, T1, T2, T3>(arg5, arg8);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg7, arg8, arg9);
        let v0 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::get_mint_request_amount<T1>(&arg0);
        let v1 = market_coin_for_underlying_ceil<T0>(v0, arg8);
        assert!(0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1) >= v1, 1003);
        assert!(v1 <= arg2, 1016);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        refresh_withdraw_window<T0, T1, T2, T3>(arg5, v2);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg5.market_coin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::coin::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1, v1, arg10)));
        arg5.withdraw_window_minted = checked_add_u64(arg5.withdraw_window_minted, v1);
        arg5.updated_at = v2;
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::destroy_mint_request<T1, 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::SCALLOP>(arg0, 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::sign(), arg3, arg4);
        let v3 = DepositEvent{
            market_id              : arg5.market_id,
            scallop_market_id      : arg5.scallop_market_id,
            underlying_value_in    : v0,
            market_coin_in         : v1,
            market_coin_change_out : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1),
            depositor              : 0x2::tx_context::sender(arg10),
        };
        0x2::event::emit<DepositEvent>(v3);
        arg1
    }

    public fun market_coin_balance<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.market_coin_balance)
    }

    public fun market_coin_for_underlying_ceil<T0: drop>(arg0: u64, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let v0 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, current_sy_index<T0>(arg1)) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun market_coin_for_underlying_floor<T0: drop>(arg0: u64, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let v0 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, current_sy_index<T0>(arg1)) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun market_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun queue_redeem<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &mut ScallopMarketVault<T0, T1, T2, T3>, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : WithdrawRequest<T0, T1, T2, T3> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3>(arg3, arg4);
        assert_scallop_market_match<T0, T1, T2, T3>(arg3, arg6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg5, arg6, arg7);
        let v0 = underlying_for_sy_floor(0x2::coin::value<T1>(&arg0), current_sy_index<T0>(arg6));
        let v1 = market_coin_for_underlying_ceil<T0>(v0, arg6);
        assert!(v1 >= arg1, 1016);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        refresh_withdraw_window<T0, T1, T2, T3>(arg3, v2);
        arg3.queued_market_coin = checked_add_u64(arg3.queued_market_coin, v1);
        arg3.updated_at = v2;
        let v3 = WithdrawRequest<T0, T1, T2, T3>{
            id                 : 0x2::object::new(arg8),
            vault_id           : 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg3),
            market_id          : arg3.market_id,
            scallop_market_id  : arg3.scallop_market_id,
            owner              : 0x2::tx_context::sender(arg8),
            underlying_value   : v0,
            market_coin_amount : v1,
            created_at         : v2,
            sy_balance         : 0x2::coin::into_balance<T1>(arg0),
        };
        let v4 = 0x2::object::id<WithdrawRequest<T0, T1, T2, T3>>(&v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg3.withdraw_queue, v4);
        let v5 = WithdrawQueuedEvent{
            request_id         : v4,
            vault_id           : 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg3),
            market_id          : arg3.market_id,
            scallop_market_id  : arg3.scallop_market_id,
            owner              : 0x2::tx_context::sender(arg8),
            underlying_value   : v0,
            market_coin_amount : v1,
            created_at         : v2,
        };
        0x2::event::emit<WithdrawQueuedEvent>(v5);
        v3
    }

    public fun queued_market_coin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.queued_market_coin
    }

    public fun redeem<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::BurnSyRequest<T1>, arg1: u64, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::SyState, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &mut ScallopMarketVault<T0, T1, T2, T3>, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T1, T2, T3>, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        assert_market_match<T0, T1, T2, T3>(arg4, arg5);
        assert_scallop_market_match<T0, T1, T2, T3>(arg4, arg7);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::get_burn_request_market_id<T1>(&arg0) == arg4.market_id, 1002);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg6, arg7, arg8);
        let v0 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::get_burn_request_amount<T1>(&arg0);
        let v1 = market_coin_for_underlying_ceil<T0>(v0, arg7);
        assert!(v1 >= arg1, 1016);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        refresh_withdraw_window<T0, T1, T2, T3>(arg4, v2);
        consume_withdraw_quota<T0, T1, T2, T3>(arg4, v1);
        arg4.updated_at = v2;
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::sy::destroy_burn_request<T1, 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::SCALLOP>(arg0, 0xbd8c7e2dfda626b2b8bf152aa5f9162b745ddd5a50449fd5f6b447086591aae8::sign::sign(), arg2, arg3);
        let v3 = RedeemEvent{
            market_id            : arg4.market_id,
            scallop_market_id    : arg4.scallop_market_id,
            underlying_value_out : v0,
            market_coin_out      : v1,
            redeemer             : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<RedeemEvent>(v3);
        0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg4.market_coin_balance, v1), arg9)
    }

    fun refresh_withdraw_window<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut ScallopMarketVault<T0, T1, T2, T3>, arg1: u64) {
        if (arg1 < arg0.withdraw_window_start_ms) {
            return
        };
        let v0 = arg1 - arg0.withdraw_window_start_ms;
        if (v0 < arg0.withdraw_window_ms) {
            return
        };
        arg0.withdraw_window_start_ms = arg0.withdraw_window_start_ms + v0 / arg0.withdraw_window_ms * arg0.withdraw_window_ms;
        arg0.withdraw_window_base_reserve = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.market_coin_balance);
        arg0.withdraw_window_withdrawn = 0;
        arg0.withdraw_window_minted = 0;
        let v1 = WithdrawWindowRolledEvent{
            vault_id            : 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg0),
            market_id           : arg0.market_id,
            window_start_ms     : arg0.withdraw_window_start_ms,
            window_base_reserve : arg0.withdraw_window_base_reserve,
        };
        0x2::event::emit<WithdrawWindowRolledEvent>(v1);
    }

    fun reject_withdraw<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: WithdrawRequest<T0, T1, T2, T3>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut ScallopMarketVault<T0, T1, T2, T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        let WithdrawRequest {
            id                 : v0,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            created_at         : _,
            sy_balance         : v8,
        } = arg0;
        let v9 = v8;
        let v10 = v0;
        let v11 = 0x2::object::uid_to_inner(&v10);
        assert_request_matches_vault<T0, T1, T2, T3>(arg2, v1, v2, v3);
        assert!(arg2.queued_market_coin >= v6, 1012);
        remove_queued_request_id<T0, T1, T2, T3>(arg2, v11);
        arg2.queued_market_coin = arg2.queued_market_coin - v6;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg4), v4);
        let v12 = WithdrawRejectedEvent{
            request_id         : v11,
            vault_id           : v1,
            market_id          : v2,
            scallop_market_id  : v3,
            owner              : v4,
            underlying_value   : v5,
            market_coin_amount : v6,
            sy_amount          : 0x2::balance::value<T1>(&v9),
            rejected_at        : arg2.updated_at,
            operator           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawRejectedEvent>(v12);
        0x2::object::delete(v10);
    }

    public fun reject_withdraw_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: WithdrawRequest<T0, T1, T2, T3>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &mut ScallopMarketVault<T0, T1, T2, T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"scallop_adapter.reject_withdraw"));
        reject_withdraw<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun reject_withdraw_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: WithdrawRequest<T0, T1, T2, T3>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &mut ScallopMarketVault<T0, T1, T2, T3>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        reject_withdraw<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5);
    }

    fun remaining_quota<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        let v0 = withdraw_quota<T0, T1, T2, T3>(arg0);
        if (v0 > arg0.withdraw_window_withdrawn) {
            v0 - arg0.withdraw_window_withdrawn
        } else {
            0
        }
    }

    public fun remaining_withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        remaining_quota<T0, T1, T2, T3>(arg0)
    }

    fun remove_queued_request_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut ScallopMarketVault<T0, T1, T2, T3>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.withdraw_queue)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.withdraw_queue, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.withdraw_queue, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 1015
    }

    public fun request_market_coin_amount<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &WithdrawRequest<T0, T1, T2, T3>) : u64 {
        arg0.market_coin_amount
    }

    public fun request_owner<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &WithdrawRequest<T0, T1, T2, T3>) : address {
        arg0.owner
    }

    public fun request_sy_amount<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &WithdrawRequest<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T1>(&arg0.sy_balance)
    }

    public fun request_underlying_value<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &WithdrawRequest<T0, T1, T2, T3>) : u64 {
        arg0.underlying_value
    }

    public fun request_vault_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &WithdrawRequest<T0, T1, T2, T3>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun scallop_market_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : 0x2::object::ID {
        arg0.scallop_market_id
    }

    fun set_withdraw_circuit_breaker<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &mut ScallopMarketVault<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg0);
        assert_withdraw_circuit_breaker_config(arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg1.withdraw_window_ms = arg2;
        arg1.withdraw_bps_per_window = arg3;
        arg1.withdraw_window_start_ms = v0;
        arg1.withdraw_window_base_reserve = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg1.market_coin_balance);
        arg1.withdraw_window_withdrawn = 0;
        arg1.withdraw_window_minted = 0;
        arg1.updated_at = v0;
        let v1 = WithdrawCircuitBreakerUpdatedEvent{
            vault_id                : 0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg1),
            market_id               : arg1.market_id,
            withdraw_window_ms      : arg2,
            withdraw_bps_per_window : arg3,
            window_start_ms         : v0,
            window_base_reserve     : arg1.withdraw_window_base_reserve,
            updater                 : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawCircuitBreakerUpdatedEvent>(v1);
    }

    public fun set_withdraw_circuit_breaker_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut ScallopMarketVault<T0, T1, T2, T3>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg0, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"scallop_adapter.set_withdraw_circuit_breaker"));
        set_withdraw_circuit_breaker<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_withdraw_circuit_breaker_by_admin<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut ScallopMarketVault<T0, T1, T2, T3>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        set_withdraw_circuit_breaker<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun underlying_dust<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        0
    }

    public fun underlying_for_sy_floor(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1102);
        let v0 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun updated_at<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.updated_at
    }

    public fun vault_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : 0x2::object::ID {
        0x2::object::id<ScallopMarketVault<T0, T1, T2, T3>>(arg0)
    }

    public fun withdraw_bps_per_window<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_bps_per_window
    }

    public fun withdraw_queue_length<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.withdraw_queue)
    }

    public fun withdraw_queue_request_id<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.withdraw_queue, arg1)
    }

    fun withdraw_quota<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg0.withdraw_window_base_reserve as u128), (arg0.withdraw_bps_per_window as u128), (10000 as u128)) as u64)
    }

    public fun withdraw_quota_per_window<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        withdraw_quota<T0, T1, T2, T3>(arg0)
    }

    public fun withdraw_window_base_reserve<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_window_base_reserve
    }

    public fun withdraw_window_minted<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_window_minted
    }

    public fun withdraw_window_ms<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_window_ms
    }

    public fun withdraw_window_start_ms<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_window_start_ms
    }

    public fun withdraw_window_withdrawn<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &ScallopMarketVault<T0, T1, T2, T3>) : u64 {
        arg0.withdraw_window_withdrawn
    }

    // decompiled from Move bytecode v7
}

