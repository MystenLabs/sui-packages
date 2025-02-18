module 0x2bc8db9697515211e4b9974e0ae959e71975d6386bc1a82b38af1923a519b6f::sui_vsui_strategy {
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
        vault_access: 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::VaultAccess,
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

    public entry fun new(arg0: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg1: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::add_strategy<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg0, arg1, arg2);
        let v1 = create(v0, arg2);
        let v2 = CreateStrategyAndJoinVaultEvent{
            vault_id    : 0x2::object::id<0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>>(arg1),
            strategy_id : *0x2::object::uid_as_inner(&v1.id),
        };
        0x2::event::emit<CreateStrategyAndJoinVaultEvent>(v2);
        0x2::transfer::share_object<Strategy>(v1);
    }

    fun add_to_collected_asset<T0>(arg0: &mut Strategy, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0, arg1);
        };
    }

    entry fun add_version(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: u64) {
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
        ((v1 - 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v0 - (arg4 as u256), 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v1, (10000 as u256), v0), (10000 as u256))) as u64)
    }

    public fun collected_asset<T0>(arg0: &Strategy) : &0x2::balance::Balance<T0> {
        assert_if_type_not_in_collected_asset<T0>(arg0);
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.collected_asset, 0x1::type_name::get<T0>())
    }

    fun create(arg0: 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::VaultAccess, arg1: &mut 0x2::tx_context::TxContext) : Strategy {
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

    public fun deposit_sold_profits(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg3: TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        assert_if_version_not_matched(arg0);
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v1,
        } = arg3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) > 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::mul_div(v1, 10000 - arg0.bias.put_back_bias_bps, 10000), 105);
        let v2 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4, 0x2::balance::withdraw_all<0x2::sui::SUI>(v2));
        let v3 = DepositProfitEvent{
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
            sui_amt     : 0x2::balance::value<0x2::sui::SUI>(&arg4),
        };
        0x2::event::emit<DepositProfitEvent>(v3);
        0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_hand_over_profit<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, arg4, arg5);
    }

    fun destroy(arg0: Strategy) : 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::VaultAccess {
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
        ((0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v0, (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) + 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (arg4 as u64)) as u256), 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div((10000 as u256), (10000 as u256), (10000 as u256) - v0), (10000 as u256)), (10000 as u256)) - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap))) as u64)
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
            let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
            assert!((arg4 as u256) <= v1, 106);
            0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg1, arg2, (((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) - 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v1 - (arg4 as u256), (10000 as u256), get_ltv(arg0, arg3, 5))) as u64))
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

    public fun rebalance(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg3: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::RebalanceAmounts, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg5: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg15: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let (v0, v1) = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::rebalance_amounts_get(arg3, &arg0.vault_access);
        if (v1 > 0) {
            let v2 = 0x2::balance::value<0x2::sui::SUI>(0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::free_balance<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2));
            let v3 = get_withdraw_amt(arg0, arg4, arg5, arg8, v2);
            let v4 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            let v5 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v4);
            let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
            if (v6 >= v1) {
                0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_repay<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
                if (0x2::balance::value<0x2::sui::SUI>(&v5) >= 1000000000) {
                    revolving_loan(arg0, arg4, arg5, arg6, v5, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
                } else {
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                };
            } else if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg4, arg5, v3) < 1000000000) {
                let v7 = if (v1 < 1000000000) {
                    calculate_required_sui_for_repay(arg0, arg4, arg5, arg8, 1000000000)
                } else {
                    calculate_required_sui_for_repay(arg0, arg4, arg5, arg8, v1)
                };
                if (v6 >= v7) {
                    let v8 = revolving_repay_and_withdraw(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v7), v1, arg15);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v8);
                    0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_repay<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
                    if (0x2::balance::value<0x2::sui::SUI>(&v5) >= 1000000000) {
                        revolving_loan(arg0, arg4, arg5, arg6, v5, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
                    } else {
                        add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                    };
                } else {
                    let v9 = v7 - v6;
                    let v10 = (0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div((v9 as u256), (6 as u256), (10000 as u256)) as u64);
                    let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg14, arg9, v9, &arg0.navi_cap);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v11);
                    let v13 = revolving_repay_and_withdraw(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v5), v1 + v10, arg15);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v13);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg7, arg8, arg9, v12, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v9 + v10), &arg0.navi_cap));
                    0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_repay<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
                    if (0x2::balance::value<0x2::sui::SUI>(&v5) >= 1000000000) {
                        revolving_loan(arg0, arg4, arg5, arg6, v5, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
                    } else {
                        add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                    };
                };
            } else {
                let (v14, v15) = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, v2);
                let v16 = revolving_repay_and_withdraw(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v14, v1, arg15);
                0x2::balance::join<0x2::sui::SUI>(&mut v5, v16);
                0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::repay_flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, v15, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v2));
                0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_repay<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
                if (0x2::balance::value<0x2::sui::SUI>(&v5) >= 1000000000) {
                    revolving_loan(arg0, arg4, arg5, arg6, v5, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
                } else {
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                };
            };
            let v17 = RepayEvent{
                vault_id    : 0x2::object::id<0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>>(arg2),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                repaid_buck : v1,
            };
            0x2::event::emit<RepayEvent>(v17);
        } else if (v0 > 0) {
            let v18 = 0x1::u64::min(v0, 0x2::balance::value<0x2::sui::SUI>(0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::free_balance<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2)));
            let v19 = 0x2::coin::from_balance<0x2::sui::SUI>(0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_borrow<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, v18), arg15);
            let v20 = BorrowEvent{
                vault_id    : 0x2::object::id<0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>>(arg2),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                borrow_amt  : v18,
            };
            0x2::event::emit<BorrowEvent>(v20);
            let v21 = 0x2::balance::zero<0x2::sui::SUI>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, 0x1::type_name::get<0x2::sui::SUI>())) {
                let v22 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
                0x2::balance::join<0x2::sui::SUI>(&mut v21, 0x2::balance::withdraw_all<0x2::sui::SUI>(v22));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v21, 0x2::coin::into_balance<0x2::sui::SUI>(v19));
            revolving_loan(arg0, arg4, arg5, arg6, v21, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
        } else {
            let v23 = 0x2::balance::zero<0x2::sui::SUI>();
            let v24 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            0x2::balance::join<0x2::sui::SUI>(&mut v23, 0x2::balance::withdraw_all<0x2::sui::SUI>(v24));
            revolving_loan(arg0, arg4, arg5, arg6, v23, arg7, arg8, arg10, arg9, arg11, arg12, arg13, arg15);
        };
    }

    public fun remove_from_vault_and_destroy(arg0: Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg13: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg14: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: address, arg17: &mut 0x2::tx_context::TxContext) : 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::StrategyRemovalTicket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI> {
        assert_if_version_not_matched(&arg0);
        assert_if_rewards_pending(&arg0);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg6, arg13, arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        let v1 = get_price(arg6, arg12, arg13, arg14, arg15, arg16, 0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::free_balance<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2));
        let (v3, v4) = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, v2);
        let v5 = &mut arg0;
        let v6 = revolving_repay_and_withdraw(v5, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, v3, (0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v0, (1000000000 as u256), v1) as u64), arg17);
        0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::repay_flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, v4, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v2));
        let v7 = &mut arg0;
        0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::withdraw_all<0x2::sui::SUI>(borrow_collected_asset_mut<0x2::sui::SUI>(v7)));
        let v8 = RemoveStrategyEvent{
            vault_id    : 0x2::object::id<0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>>(arg2),
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
        };
        0x2::event::emit<RemoveStrategyEvent>(v8);
        0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::new_strategy_removal_ticket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(destroy(arg0), v6)
    }

    fun revolving_loan(arg0: &mut Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v0, arg4);
        let v1 = get_ltv(arg0, arg6, 5);
        let v2 = get_borrow_amt(arg0, arg6, arg1, arg2, (0x2::balance::value<0x2::sui::SUI>(&v0) as u256));
        while (0x2::balance::value<0x2::sui::SUI>(&v0) >= 1000000000) {
            let v3 = volo_stake(arg1, arg2, arg3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0), arg12);
            let v4 = (0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3)) as u256), v1, (10000 as u256)) as u64);
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
        let v1 = arg12 + v0;
        let v2 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg1, arg2, v1);
        let v3 = calculate_required_sui_for_repay(arg0, arg1, arg2, arg5, v1);
        if (v0 >= v3) {
            let (v4, v5) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v3), v2, arg13);
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v5, arg13));
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, v4);
        } else {
            while (0x2::balance::value<0x2::sui::SUI>(&arg11) < v1) {
                if (0x2::balance::value<0x2::sui::SUI>(&arg11) >= v3) {
                    let v6 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
                    let v7 = 0x2::balance::zero<0x2::sui::SUI>();
                    if (0x2::balance::value<0x2::sui::SUI>(&arg11) >= (v6 as u64)) {
                        0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, (v6 as u64)));
                    } else {
                        0x2::balance::join<0x2::sui::SUI>(&mut v7, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v3));
                    };
                    let (v8, v9) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v7, v2, arg13);
                    let v10 = volo_unstake(arg1, arg2, arg3, v9, arg13);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg11, v10);
                    0x2::balance::join<0x2::sui::SUI>(&mut arg11, v8);
                    continue
                };
                let v11 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
                let v12 = 0x2::balance::zero<0x2::sui::SUI>();
                if (0x2::balance::value<0x2::sui::SUI>(&arg11) >= (v11 as u64)) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, (v11 as u64)));
                } else {
                    0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg11));
                };
                let v13 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&v12));
                let (v14, v15) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v12, v13, arg13);
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v15, arg13));
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, v14);
            };
        };
        let v16 = 0x2::balance::value<0x2::sui::SUI>(&arg11);
        assert!(v16 >= v1, 104);
        add_to_collected_asset<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v16 - v1));
        arg11
    }

    entry fun set_borrow_bias(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: u64) {
        arg0.bias.borrow_bias_bps = arg2;
    }

    entry fun set_put_back_bias(arg0: &mut Strategy, arg1: u64) {
        arg0.bias.put_back_bias_bps = arg1;
    }

    public fun skim_base_profits(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
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

    public fun take_profits_for_selling(arg0: &mut Strategy, arg1: &0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::AdminCap<0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: address, arg12: address, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
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
            sui_est_amt : (0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div(v4, (v3 as u256), get_price(arg5, arg6, arg7, arg8, arg9, arg11, 0)) as u64),
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

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::Vault<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg2: &mut 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::WithdrawTicket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg14: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let v0 = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::withdraw_ticket_to_withdraw<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access);
        if (v0 > 0) {
            let v1 = 0x2::balance::value<0x2::sui::SUI>(0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::free_balance<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg1));
            let v2 = get_withdraw_amt(arg0, arg3, arg4, arg7, v1);
            if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, v2) < 1000000000) {
                let v3 = if (v0 < 1000000000 && (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) >= (1000000000 as u256)) {
                    calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, 1000000000)
                } else {
                    calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, v0)
                };
                let v4 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
                let v5 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v4);
                let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
                if (v6 >= v3) {
                    let v7 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v3), v0, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v7);
                    0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v0));
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                } else {
                    let v8 = v3 - v6;
                    let v9 = (0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::utils::u256_mul_div((v8 as u256), (6 as u256), (10000 as u256)) as u64);
                    let (v10, v11) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg13, arg8, v8, &arg0.navi_cap);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v10);
                    let v12 = 0x2::balance::zero<0x2::sui::SUI>();
                    let v13 = (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256);
                    if (v6 >= (v13 as u64)) {
                        0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x2::balance::split<0x2::sui::SUI>(&mut v5, (v13 as u64)));
                    } else {
                        0x2::balance::join<0x2::sui::SUI>(&mut v12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v5));
                    };
                    let v14 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, v0 + v9, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, v14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg6, arg7, arg8, v11, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v8 + v9), &arg0.navi_cap));
                    0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v0));
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v5);
                };
            } else {
                let (v15, v16) = 0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg1, &arg0.vault_access, v1);
                let v17 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v15, v0, arg14);
                0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::repay_flash_loan<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg1, &arg0.vault_access, v16, 0x2::balance::split<0x2::sui::SUI>(&mut v17, v1));
                0x64b80daba2e1975c9f9ff0e9d82b6e08499bcbcee642fa8e6db7ebcbd1b9665c::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0x733f575e7f21ed71e2a9633d99f7bf5657d9bbbd424c2b328c522cac010e326c::st_sui::ST_SUI>(arg2, &arg0.vault_access, 0x2::balance::split<0x2::sui::SUI>(&mut v17, v0));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v17);
            };
        };
        let v18 = WithdrawEvent{redeem_amt: v0};
        0x2::event::emit<WithdrawEvent>(v18);
    }

    // decompiled from Move bytecode v6
}

