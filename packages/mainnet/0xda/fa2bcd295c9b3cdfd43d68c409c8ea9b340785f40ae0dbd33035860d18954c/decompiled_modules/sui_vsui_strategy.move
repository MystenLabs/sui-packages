module 0xec31703dbf838e578b8eab816d766d9861f23fe2b9afab8fa419f1143e314307::sui_vsui_strategy {
    struct CreateStrategyAndJoinVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
    }

    struct RemoveStrategyEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
    }

    struct SkimProfitsEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        vsui_amt: u64,
        navx_amt: u64,
    }

    struct DepositProfitEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        sui_amt: u64,
    }

    struct WithdrawEvent has copy, drop {
        redeem_amt: u64,
    }

    struct RepayEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        repaid_buck: u64,
    }

    struct BorrowEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        borrow_amt: u64,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        vault_access: 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::VaultAccess,
        collected_asset: 0x2::bag::Bag,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        bias: Bias,
    }

    struct Bias has drop, store {
        borrow_bias_bps: u64,
        put_back_bias_bps: u64,
    }

    struct TakeAssetReceipt<phantom T0> {
        take_amt: u64,
        sui_est_amt: u64,
    }

    public entry fun new(arg0: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg1: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::add_strategy<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg0, arg1, arg2);
        let v1 = create(v0, arg2);
        let v2 = CreateStrategyAndJoinVaultEvent{
            vault_id    : 0x2::object::id<0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>>(arg1),
            strategy_id : *0x2::object::uid_as_inner(&v1.id),
        };
        0x2::event::emit<CreateStrategyAndJoinVaultEvent>(v2);
        0x2::transfer::share_object<Strategy>(v1);
    }

    public fun remove(arg0: Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>) : 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::StrategyRemovalTicket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI> {
        assert_if_version_not_matched(&arg0);
        assert_if_rewards_pending(&arg0);
        let v0 = RemoveStrategyEvent{
            vault_id    : 0x2::object::id<0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>>(arg2),
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
        };
        0x2::event::emit<RemoveStrategyEvent>(v0);
        0x2::balance::destroy_zero<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>>(&mut arg0.collected_asset, 0x1::type_name::get<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>()));
        0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut arg0.collected_asset, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()));
        0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::new_strategy_removal_ticket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(destroy(arg0), 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.collected_asset, 0x1::type_name::get<0x2::sui::SUI>()))
    }

    fun add_to_collected_asset<T0>(arg0: &mut Strategy, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0, arg1);
        };
    }

    entry fun add_version(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    fun assert_if_rewards_pending(arg0: &Strategy) {
        assert!(0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&arg0.collected_asset, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>())) == 0, 101);
        assert!(0x2::balance::value<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>>(&arg0.collected_asset, 0x1::type_name::get<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>())) == 0, 101);
    }

    fun assert_if_type_not_in_collected_asset<T0>(arg0: &Strategy) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, 0x1::type_name::get<T0>()), 102);
    }

    fun assert_if_version_not_matched(arg0: &Strategy) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 100);
    }

    public fun bias(arg0: &Strategy) : &Bias {
        &arg0.bias
    }

    fun borrow_collected_asset_mut<T0>(arg0: &mut Strategy) : &mut 0x2::balance::Balance<T0> {
        assert_if_type_not_in_collected_asset<T0>(arg0);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, 0x1::type_name::get<T0>())
    }

    public fun calculate_required_sui_for_repay(arg0: &Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u64) : u64 {
        assert_if_version_not_matched(arg0);
        let v0 = (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        assert!(v0 >= (arg4 as u256), 107);
        ((v1 - 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v0 - (arg4 as u256), 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v1, (10000 as u256), v0), (10000 as u256))) as u64)
    }

    public fun collected_asset<T0>(arg0: &Strategy) : &0x2::balance::Balance<T0> {
        assert_if_type_not_in_collected_asset<T0>(arg0);
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.collected_asset, 0x1::type_name::get<T0>())
    }

    fun create(arg0: 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::VaultAccess, arg1: &mut 0x2::tx_context::TxContext) : Strategy {
        let v0 = Bias{
            borrow_bias_bps   : 500,
            put_back_bias_bps : 100,
        };
        Strategy{
            id              : 0x2::object::new(arg1),
            versions        : 0x2::vec_set::singleton<u64>(1),
            vault_access    : arg0,
            collected_asset : 0x2::bag::new(arg1),
            navi_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            bias            : v0,
        }
    }

    public fun deposit_all_non_sui_asset_back(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg4: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_if_version_not_matched(arg0);
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v1,
        } = arg3;
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v3,
        } = arg2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) > 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::mul_div(v1 + v3, 10000 - arg0.bias.put_back_bias_bps, 10000), 105);
        0x2::balance::join<0x2::sui::SUI>(borrow_collected_asset_mut<0x2::sui::SUI>(arg0), arg4);
    }

    public fun deposit_sold_profits(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg3: TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        assert_if_version_not_matched(arg0);
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v1,
        } = arg3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) > 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::mul_div(v1, 10000 - arg0.bias.put_back_bias_bps, 10000), 105);
        let v2 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4, 0x2::balance::withdraw_all<0x2::sui::SUI>(v2));
        let v3 = DepositProfitEvent{
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
            sui_amt     : 0x2::balance::value<0x2::sui::SUI>(&arg4),
        };
        0x2::event::emit<DepositProfitEvent>(v3);
        0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_hand_over_profit<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg2, &arg0.vault_access, arg4, arg5);
    }

    fun destroy(arg0: Strategy) : 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::VaultAccess {
        let Strategy {
            id              : v0,
            versions        : _,
            vault_access    : v2,
            collected_asset : v3,
            navi_cap        : v4,
            bias            : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v3);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::delete_account(v4);
        v2
    }

    fun get_borrow_amt(arg0: &Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: u256) : u64 {
        let v0 = get_ltv(arg0, arg1, 5);
        ((0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v0, (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) + 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (arg4 as u64)) as u256), 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div((10000 as u256), (10000 as u256), (10000 as u256) - v0), (10000 as u256)), (10000 as u256)) - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap))) as u64)
    }

    fun get_ltv(arg0: &Strategy, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg1, arg2) / 100000000000000000000000 - (arg0.bias.borrow_bias_bps as u256)
    }

    fun get_price(arg0: &0x2::clock::Clock, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg2: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: address, arg6: u8) : u256 {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg0, arg1, arg2, arg3, arg4, arg5);
        let (_, v1, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg2, arg6);
        v1
    }

    fun get_withdraw_amt(arg0: &Strategy, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: u64) : u64 {
        if (arg4 == 0) {
            0
        } else {
            let v1 = (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256);
            let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
            assert!((arg4 as u256) <= v2, 106);
            0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg1, arg2, ((v1 - 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v2 - (arg4 as u256), (10000 as u256), 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v2, (10000 as u256), v1))) as u64))
        }
    }

    fun navi_claim_rewards(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : (0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg5, arg3, arg2, 5, 1, &arg0.navi_cap);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg1, arg5, arg4, arg2, 7, 1, &arg0.navi_cap);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg5, arg3, arg2, 5, 3, &arg0.navi_cap));
        0x2::balance::join<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg1, arg5, arg4, arg2, 7, 3, &arg0.navi_cap));
        (v0, v1)
    }

    fun navi_collateral_and_borrow(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg2, arg3, 5, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg5, arg10), arg7, arg8, &arg0.navi_cap);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<0x2::sui::SUI>(arg1, arg9, arg2, arg4, 0, arg6, arg8, &arg0.navi_cap)
    }

    fun navi_repay_and_withdraw_collateral(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x2::balance::destroy_zero<0x2::sui::SUI>(arg8);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<0x2::sui::SUI>(arg1, arg7, arg2, arg3, 0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg8), arg10), arg6, &arg0.navi_cap), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg7, arg2, arg4, 5, arg9, arg5, arg6, &arg0.navi_cap))
    }

    public fun rebalance(arg0: &mut Strategy, arg1: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::RebalanceAmounts, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg14: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let (v0, v1) = 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::rebalance_amounts_get(arg2, &arg0.vault_access);
        if (v1 > 0) {
            let v2 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v2);
            if (0x2::balance::value<0x2::sui::SUI>(&v3) >= v1) {
                0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_repay<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v3);
            } else {
                let v4 = 0x2::balance::value<0x2::sui::SUI>(0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::free_balance<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1));
                assert!(((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) as u64) >= 1000000000, 108);
                let v5 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, 1000000000);
                if (v4 >= v5) {
                    let (v6, v7) = 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::flash_loan<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, v4);
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v6);
                    let v8 = v1 + v4;
                    let v9 = v8;
                    if (v8 < 1000000000) {
                        v9 = 1000000000;
                    };
                    let v10 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v3), v9, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v10);
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::repay_flash_loan<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, v7, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v4));
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_repay<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
                } else {
                    let v11 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, v1);
                    let v12 = v11;
                    if (v11 < v5) {
                        v12 = v5;
                    };
                    let (v13, v14) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg13, arg8, v12, &arg0.navi_cap);
                    let v15 = v13;
                    let v16 = 0x2::balance::value<0x2::sui::SUI>(&v15);
                    let v17 = (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div((v16 as u256), (6 as u256), (10000 as u256)) as u64);
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v15);
                    let v18 = v1 + v16 + v17;
                    let v19 = v18;
                    if (v18 < 1000000000) {
                        v19 = 1000000000;
                    };
                    let v20 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v3), v19, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, v20);
                    0x2::balance::join<0x2::sui::SUI>(&mut v3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg6, arg7, arg8, v14, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v16 + v17), &arg0.navi_cap));
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_repay<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v1));
                };
                if (0x2::balance::value<0x2::sui::SUI>(&v3) >= 1000000000) {
                    revolving_loan(arg0, arg3, arg4, arg5, v3, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg14);
                } else {
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v3);
                };
            };
            let v21 = RepayEvent{
                vault_id    : 0x2::object::id<0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>>(arg1),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                repaid_buck : v1,
            };
            0x2::event::emit<RepayEvent>(v21);
        } else if (v0 > 0) {
            let v22 = 0x1::u64::min(v0, 0x2::balance::value<0x2::sui::SUI>(0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::free_balance<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1)));
            let v23 = 0x2::coin::from_balance<0x2::sui::SUI>(0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_borrow<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, v22), arg14);
            let v24 = BorrowEvent{
                vault_id    : 0x2::object::id<0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>>(arg1),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                borrow_amt  : v22,
            };
            0x2::event::emit<BorrowEvent>(v24);
            let v25 = 0x2::balance::zero<0x2::sui::SUI>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, 0x1::type_name::get<0x2::sui::SUI>())) {
                let v26 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
                0x2::balance::join<0x2::sui::SUI>(&mut v25, 0x2::balance::withdraw_all<0x2::sui::SUI>(v26));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v25, 0x2::coin::into_balance<0x2::sui::SUI>(v23));
            revolving_loan(arg0, arg3, arg4, arg5, v25, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg14);
        } else {
            let v27 = 0x2::balance::zero<0x2::sui::SUI>();
            let v28 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            0x2::balance::join<0x2::sui::SUI>(&mut v27, 0x2::balance::withdraw_all<0x2::sui::SUI>(v28));
            revolving_loan(arg0, arg3, arg4, arg5, v27, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg14);
        };
    }

    fun revolving_loan(arg0: &mut Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v0, arg4);
        let v1 = get_ltv(arg0, arg6, 5);
        let v2 = get_borrow_amt(arg0, arg6, arg1, arg2, (0x2::balance::value<0x2::sui::SUI>(&v0) as u256));
        while (0x2::balance::value<0x2::sui::SUI>(&v0) >= 1000000000) {
            let v3 = volo_stake(arg1, arg2, arg3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0), arg12);
            let v4 = (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3)) as u256), v1, (10000 as u256)) as u64);
            if (v4 > v2) {
                let v5 = navi_collateral_and_borrow(arg0, arg5, arg6, arg7, arg8, v3, v2, arg9, arg10, arg11, arg12);
                0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
                break
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, navi_collateral_and_borrow(arg0, arg5, arg6, arg7, arg8, v3, v4, arg9, arg10, arg11, arg12));
            v2 = v2 - v4;
        };
        add_to_collected_asset<0x2::sui::SUI>(arg0, v0);
    }

    fun revolving_repay_and_withdraw(arg0: &mut Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg11);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        let v2 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg1, arg2, arg12);
        let v3 = v2;
        if (arg12 < ((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg5, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) as u64)) {
            v3 = v2 + 1;
        };
        let v4 = if (v0 < (v1 as u64)) {
            get_withdraw_amt(arg0, arg1, arg2, arg5, v0)
        } else {
            get_withdraw_amt(arg0, arg1, arg2, arg5, (v1 as u64))
        };
        if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, v4) < 1000000000) {
            abort 108
        };
        let v5 = calculate_required_sui_for_repay(arg0, arg1, arg2, arg5, arg12);
        if (v0 >= v5) {
            let (v6, v7) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v5), v3 - 200, arg13);
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v7, arg13));
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, v6);
        } else {
            loop {
                let v8 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
                if ((v8 as u64) <= 0x2::balance::value<0x2::sui::SUI>(&arg11)) {
                    let v9 = get_withdraw_amt(arg0, arg1, arg2, arg5, (v8 as u64));
                    if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, v9) < 1000000000) {
                        break
                    } else {
                        let v10 = 0x2::balance::split<0x2::sui::SUI>(&mut arg11, (v8 as u64));
                        let v11 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&v10));
                        let (v12, v13) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v10, v11, arg13);
                        let v14 = volo_unstake(arg1, arg2, arg3, v13, arg13);
                        0x2::balance::join<0x2::sui::SUI>(&mut arg11, v14);
                        0x2::balance::join<0x2::sui::SUI>(&mut arg11, v12);
                        break
                    };
                };
                let v15 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&arg11));
                if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, v15) < 1000000000) {
                    break
                };
                let v16 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg11);
                let v17 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&v16));
                let (v18, v19) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v16, v17, arg13);
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v19, arg13));
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, v18);
                if (0x2::balance::value<0x2::sui::SUI>(&arg11) >= arg12) {
                    break
                };
            };
        };
        arg11
    }

    entry fun set_borrow_bias(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: u64) {
        arg0.bias.borrow_bias_bps = arg2;
    }

    entry fun set_put_back_bias(arg0: &mut Strategy, arg1: u64) {
        arg0.bias.put_back_bias_bps = arg1;
    }

    public fun skim_base_profits(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        assert_if_version_not_matched(arg0);
        let (v0, v1) = navi_claim_rewards(arg0, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        add_to_collected_asset<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, v3);
        add_to_collected_asset<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg0, v2);
        let v4 = SkimProfitsEvent{
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
            vsui_amt    : 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3),
            navx_amt    : 0x2::balance::value<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&v2),
        };
        0x2::event::emit<SkimProfitsEvent>(v4);
    }

    public fun take_all_asset_for_selling(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg15: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg16: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg17: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg18: address, arg19: address, arg20: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg21: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        assert_if_version_not_matched(arg0);
        let v0 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v0);
        let v2 = borrow_collected_asset_mut<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0);
        let v3 = 0x2::balance::withdraw_all<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v2);
        let v4 = borrow_collected_asset_mut<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg0);
        let v5 = 0x2::balance::withdraw_all<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(v4);
        let (v6, v7) = navi_claim_rewards(arg0, arg5, arg6, arg9, arg10, arg12);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v3, v6);
        0x2::balance::join<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&mut v5, v7);
        let v8 = (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg6, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg6, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        if ((v8 as u64) >= 1000000000) {
            let (v10, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg20, arg7, (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v9, (10000 as u256), ((10000 + 6) as u256)) as u64), &arg0.navi_cap);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            let v12 = revolving_repay_and_withdraw(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11, arg12, arg13, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1), (v8 as u64), arg21);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v12);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg5, arg6, arg7, v11, 0x2::balance::split<0x2::sui::SUI>(&mut v1, (v9 as u64)), &arg0.navi_cap));
        };
        add_to_collected_asset<0x2::sui::SUI>(arg0, v1);
        let v13 = 0x2::balance::value<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&v5);
        let v14 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3);
        let v15 = get_price(arg5, arg14, arg13, arg15, arg17, arg19, 7);
        let v16 = TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>{
            take_amt    : v13,
            sui_est_amt : (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v15, (v13 as u256), get_price(arg5, arg14, arg13, arg15, arg16, arg18, 0)) as u64),
        };
        let v17 = TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>{
            take_amt    : v14,
            sui_est_amt : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, v14),
        };
        (v3, v5, v17, v16)
    }

    public fun take_profits_for_selling(arg0: &mut Strategy, arg1: &0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::AdminCap<0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: address, arg12: address, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        assert_if_version_not_matched(arg0);
        let v0 = borrow_collected_asset_mut<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0);
        let v1 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0);
        if (v1 >= 1000000000) {
            add_to_collected_asset<0x2::sui::SUI>(arg0, volo_unstake(arg2, arg3, arg4, 0x2::balance::split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0, v1), arg13));
        };
        let v2 = borrow_collected_asset_mut<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg0);
        let v3 = 0x2::balance::value<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(v2);
        let v4 = get_price(arg5, arg6, arg7, arg8, arg10, arg12, 7);
        let v5 = TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>{
            take_amt    : v3,
            sui_est_amt : (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div(v4, (v3 as u256), get_price(arg5, arg6, arg7, arg8, arg9, arg11, 0)) as u64),
        };
        (0x2::balance::split<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(v2, v3), v5)
    }

    fun volo_stake(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::stake_non_entry(arg0, arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg4))
    }

    fun volo_unstake(arg0: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>();
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, arg3);
        let v1 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::mint_ticket_non_entry(arg0, arg1, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v0, arg4), arg4);
        assert!(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::unstake_ticket::is_unlocked(&v1, arg4), 103);
        0x2::coin::into_balance<0x2::sui::SUI>(0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::burn_ticket_non_entry(arg0, arg2, v1, arg4))
    }

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::Vault<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg2: &mut 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::WithdrawTicket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg14: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let v0 = 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::withdraw_ticket_to_withdraw<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg2, &arg0.vault_access);
        if (v0 > 0) {
            let v1 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v1);
            if (0x2::balance::value<0x2::sui::SUI>(&v2) >= v0) {
                0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v0));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v2);
            } else {
                let v3 = 0x2::balance::value<0x2::sui::SUI>(0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::free_balance<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1));
                assert!(((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) as u64) >= 1000000000, 108);
                let v4 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, 1000000000);
                if (v3 >= v4) {
                    let (v5, v6) = 0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::flash_loan<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, v3);
                    0x2::balance::join<0x2::sui::SUI>(&mut v2, v5);
                    let v7 = v0 + v3;
                    let v8 = v7;
                    if (v7 < 1000000000) {
                        v8 = 1000000000;
                    };
                    let v9 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v2), v8, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v2, v9);
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::repay_flash_loan<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg1, &arg0.vault_access, v6, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v0));
                } else {
                    let v10 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, v0);
                    let v11 = v10;
                    if (v10 < v4) {
                        v11 = v4;
                    };
                    let (v12, v13) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg13, arg8, v11, &arg0.navi_cap);
                    let v14 = v12;
                    let v15 = 0x2::balance::value<0x2::sui::SUI>(&v14);
                    let v16 = (0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::utils::u256_mul_div((v15 as u256), (6 as u256), (10000 as u256)) as u64);
                    0x2::balance::join<0x2::sui::SUI>(&mut v2, v14);
                    let v17 = v0 + v15 + v16;
                    let v18 = v17;
                    if (v17 < 1000000000) {
                        v18 = 1000000000;
                    };
                    let v19 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v2), v18, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v2, v19);
                    0x2::balance::join<0x2::sui::SUI>(&mut v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg6, arg7, arg8, v13, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v15 + v16), &arg0.navi_cap));
                    0x78382793ee7a27d0a4ee440203382bb63f383d9b52feb425b839a9ac4d6dc443::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x95aae76d1b8942f0f3ea0731310e83c290a9573553c62b84b541cac49114b580::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v0));
                };
                add_to_collected_asset<0x2::sui::SUI>(arg0, v2);
            };
        };
        let v20 = WithdrawEvent{redeem_amt: v0};
        0x2::event::emit<WithdrawEvent>(v20);
    }

    // decompiled from Move bytecode v6
}

