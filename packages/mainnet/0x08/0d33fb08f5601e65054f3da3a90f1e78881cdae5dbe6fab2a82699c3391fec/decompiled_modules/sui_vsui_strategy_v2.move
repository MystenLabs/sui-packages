module 0xf5af6fc21dc6a529e072937770fe1dc4b1ed166331333fa5568ccc71460fc45a::sui_vsui_strategy_v2 {
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
        vault_access: 0x1::option::Option<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>,
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

    public entry fun new(arg0: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg1: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::add_strategy<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg0, arg1, arg2);
        let v1 = create(v0, arg2);
        let v2 = CreateStrategyAndJoinVaultEvent{
            vault_id    : 0x2::object::id<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>>(arg1),
            strategy_id : *0x2::object::uid_as_inner(&v1.id),
        };
        0x2::event::emit<CreateStrategyAndJoinVaultEvent>(v2);
        0x2::transfer::share_object<Strategy>(v1);
    }

    public fun remove(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>) : 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::StrategyRemovalTicket<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI> {
        assert_if_version_not_matched(arg0);
        assert_if_rewards_pending(arg0);
        let v0 = RemoveStrategyEvent{
            vault_id    : 0x2::object::id<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>>(arg2),
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
        };
        0x2::event::emit<RemoveStrategyEvent>(v0);
        0x2::balance::destroy_zero<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>>(&mut arg0.collected_asset, 0x1::type_name::get<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>()));
        0x2::balance::destroy_zero<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>>(&mut arg0.collected_asset, 0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>()));
        0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::new_strategy_removal_ticket<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(0x1::option::extract<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&mut arg0.vault_access), 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.collected_asset, 0x1::type_name::get<0x2::sui::SUI>()))
    }

    fun add_to_collected_asset<T0>(arg0: &mut Strategy, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_asset, v0, arg1);
        };
    }

    entry fun add_version(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: u64) {
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
        assert!(v0 >= (arg4 as u256), 106);
        ((v1 - 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v0 - (arg4 as u256), 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v1, (10000 as u256), v0), (10000 as u256))) as u64)
    }

    public fun collected_asset<T0>(arg0: &Strategy) : &0x2::balance::Balance<T0> {
        assert_if_type_not_in_collected_asset<T0>(arg0);
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.collected_asset, 0x1::type_name::get<T0>())
    }

    fun create(arg0: 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess, arg1: &mut 0x2::tx_context::TxContext) : Strategy {
        let v0 = Bias{
            borrow_bias_bps   : 500,
            put_back_bias_bps : 100,
        };
        Strategy{
            id              : 0x2::object::new(arg1),
            versions        : 0x2::vec_set::singleton<u64>(1),
            vault_access    : 0x1::option::some<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(arg0),
            collected_asset : 0x2::bag::new(arg1),
            navi_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            bias            : v0,
        }
    }

    public fun deposit_all_non_sui_asset_back(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg4: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_if_version_not_matched(arg0);
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v1,
        } = arg3;
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v3,
        } = arg2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) > 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::mul_div(v1 + v3, 10000 - arg0.bias.put_back_bias_bps, 10000), 104);
        0x2::balance::join<0x2::sui::SUI>(borrow_collected_asset_mut<0x2::sui::SUI>(arg0), arg4);
    }

    public fun deposit_sold_profits(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg3: TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock) {
        assert_if_version_not_matched(arg0);
        let TakeAssetReceipt {
            take_amt    : _,
            sui_est_amt : v1,
        } = arg3;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg4) > 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::mul_div(v1, 10000 - arg0.bias.put_back_bias_bps, 10000), 104);
        let v2 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4, 0x2::balance::withdraw_all<0x2::sui::SUI>(v2));
        let v3 = DepositProfitEvent{
            strategy_id : *0x2::object::uid_as_inner(&arg0.id),
            sui_amt     : 0x2::balance::value<0x2::sui::SUI>(&arg4),
        };
        0x2::event::emit<DepositProfitEvent>(v3);
        0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_hand_over_profit<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg2, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), arg4, arg5);
    }

    fun get_borrow_amt(arg0: &Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: u256) : u64 {
        let v0 = get_ltv(arg0, arg1, 5);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        let v2 = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v0, (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) + 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (arg4 as u64)) as u256), 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div((10000 as u256), (10000 as u256), (10000 as u256) - v0), (10000 as u256)), (10000 as u256));
        if (v2 > v1) {
            ((v2 - v1) as u64)
        } else {
            0
        }
    }

    fun get_current_valuation(arg0: &Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) : u64 {
        (((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) - 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg1, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap))) as u64)
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
            assert!((arg4 as u256) <= v2, 105);
            0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::to_shares(arg1, arg2, ((v1 - 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v2 - (arg4 as u256), (10000 as u256), 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v2, (10000 as u256), v1))) as u64))
        }
    }

    fun navi_claim_rewards(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) : (0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg5, arg3, arg2, 5, 1, &arg0.navi_cap);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg5, arg3, arg2, 0, 3, &arg0.navi_cap));
        (v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg1, arg5, arg4, arg2, 5, 1, &arg0.navi_cap))
    }

    fun navi_claim_rewards_with_incentive_v3(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) : (0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let (v3, _, _, _, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg1, arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)));
        let v8 = v7;
        let v9 = v3;
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9));
        let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg3, arg2, arg4, v0, 0x1::vector::pop_back<vector<address>>(&mut v8), &arg0.navi_cap);
        0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9));
        0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9));
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg3, arg2, arg4, v1, 0x1::vector::pop_back<vector<address>>(&mut v8), &arg0.navi_cap));
        (v10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg1, arg3, arg2, arg5, v2, 0x1::vector::pop_back<vector<address>>(&mut v8), &arg0.navi_cap))
    }

    fun navi_collateral_and_borrow(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg2, arg3, 5, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg5, arg10), arg7, arg8, &arg0.navi_cap);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<0x2::sui::SUI>(arg1, arg9, arg2, arg4, 0, arg6, arg7, arg8, &arg0.navi_cap)
    }

    fun navi_repay_and_withdraw_collateral(arg0: &Strategy, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>) {
        0x2::balance::destroy_zero<0x2::sui::SUI>(arg8);
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<0x2::sui::SUI>(arg1, arg7, arg2, arg3, 0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg8), arg10), arg5, arg6, &arg0.navi_cap), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg1, arg7, arg2, arg4, 5, arg9, arg5, arg6, &arg0.navi_cap))
    }

    public fun rebalance(arg0: &mut Strategy, arg1: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::RebalanceAmounts, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg14: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let (v0, v1, _) = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::rebalance_amounts_get(arg2, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access));
        if (v1 > 0) {
            let v3 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            let v4 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v3);
            if (0x2::balance::value<0x2::sui::SUI>(&v4) >= v1) {
                0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_repay<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::split<0x2::sui::SUI>(&mut v4, v1));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v4);
            } else {
                let v5 = 0x2::balance::value<0x2::sui::SUI>(0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::free_balance<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1));
                assert!(((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) as u64) >= 1000000000, 107);
                let v6 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, 1000000000);
                if (v5 >= v6) {
                    let (v7, v8) = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::flash_loan<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), v5);
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, v7);
                    let v9 = v1 + v5;
                    let v10 = v9;
                    if (v9 < 1000000000) {
                        v10 = 1000000000;
                    };
                    let v11 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v4), v10, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, v11);
                    0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::repay_flash_loan<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), v8, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v5));
                    0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_repay<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::split<0x2::sui::SUI>(&mut v4, v1));
                } else {
                    let v12 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, v1);
                    let v13 = v12;
                    if (v12 < v6) {
                        v13 = v6;
                    };
                    let (v14, v15) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_borrow<0x2::sui::SUI>(arg13, v13);
                    let v16 = v14;
                    let v17 = 0x2::balance::value<0x2::sui::SUI>(&v16);
                    let v18 = (0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div((v17 as u256), (5 as u256), (10000 as u256)) as u64);
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, v16);
                    let v19 = v1 + v17 + v18;
                    let v20 = v19;
                    if (v19 < 1000000000) {
                        v20 = 1000000000;
                    };
                    let v21 = revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v4), v20, arg14);
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, v21);
                    0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_repay<0x2::sui::SUI>(arg13, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v17 + v18), v15);
                    0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_repay<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::split<0x2::sui::SUI>(&mut v4, v1));
                };
                if (0x2::balance::value<0x2::sui::SUI>(&v4) >= 1000000000) {
                    revolving_loan(arg0, arg3, arg4, arg5, v4, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg13, arg14);
                } else {
                    add_to_collected_asset<0x2::sui::SUI>(arg0, v4);
                };
            };
            let v22 = RepayEvent{
                vault_id    : 0x2::object::id<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>>(arg1),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                repaid_buck : v1,
            };
            0x2::event::emit<RepayEvent>(v22);
        } else if (v0 > 0) {
            let v23 = 0x1::u64::min(v0, 0x2::balance::value<0x2::sui::SUI>(0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::free_balance<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1)));
            let v24 = 0x2::coin::from_balance<0x2::sui::SUI>(0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_borrow<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), v23), arg14);
            let v25 = BorrowEvent{
                vault_id    : 0x2::object::id<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>>(arg1),
                strategy_id : *0x2::object::uid_as_inner(&arg0.id),
                borrow_amt  : v23,
            };
            0x2::event::emit<BorrowEvent>(v25);
            let v26 = 0x2::balance::zero<0x2::sui::SUI>();
            if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.collected_asset, 0x1::type_name::get<0x2::sui::SUI>())) {
                let v27 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
                0x2::balance::join<0x2::sui::SUI>(&mut v26, 0x2::balance::withdraw_all<0x2::sui::SUI>(v27));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v26, 0x2::coin::into_balance<0x2::sui::SUI>(v24));
            revolving_loan(arg0, arg3, arg4, arg5, v26, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg13, arg14);
        } else {
            let v28 = 0x2::balance::zero<0x2::sui::SUI>();
            let v29 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            0x2::balance::join<0x2::sui::SUI>(&mut v28, 0x2::balance::withdraw_all<0x2::sui::SUI>(v29));
            revolving_loan(arg0, arg3, arg4, arg5, v28, arg6, arg7, arg9, arg8, arg10, arg11, arg12, arg13, arg14);
        };
        0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_update_valuation<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), arg2, get_current_valuation(arg0, arg7, arg3, arg4));
    }

    fun revolving_loan(arg0: &mut Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v0, arg4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = get_borrow_amt(arg0, arg6, arg1, arg2, (v1 as u256));
        if (v1 + v2 >= 1000000000) {
            let v3 = v2 + (0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div((v2 as u256), (5 as u256), (10000 as u256)) as u64);
            let (v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_borrow<0x2::sui::SUI>(arg12, v2);
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
            let v6 = volo_stake(arg1, arg2, arg3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0), arg13);
            0x2::balance::join<0x2::sui::SUI>(&mut v0, navi_collateral_and_borrow(arg0, arg5, arg6, arg7, arg8, v6, v3, arg9, arg10, arg11, arg13));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_repay<0x2::sui::SUI>(arg12, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v3), v5);
        };
        add_to_collected_asset<0x2::sui::SUI>(arg0, v0);
    }

    fun revolving_repay_and_withdraw(arg0: &Strategy, arg1: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
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
            abort 107
        };
        let v5 = calculate_required_sui_for_repay(arg0, arg1, arg2, arg5, arg12);
        if (v0 >= v5) {
            let v6 = 0x2::balance::zero<0x2::sui::SUI>();
            let v7 = get_withdraw_amt(arg0, arg1, arg2, arg5, v5);
            if (v7 < v3) {
                0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v5 + 10));
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::split<0x2::sui::SUI>(&mut arg11, v5));
            };
            let (v8, v9) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v6, v3, arg13);
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v9, arg13));
            0x2::balance::join<0x2::sui::SUI>(&mut arg11, v8);
        } else {
            loop {
                let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg5, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
                if ((v10 as u64) <= 0x2::balance::value<0x2::sui::SUI>(&arg11)) {
                    let v11 = get_withdraw_amt(arg0, arg1, arg2, arg5, (v10 as u64));
                    if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, v11) < 1000000000) {
                        break
                    } else {
                        let v12 = 0x2::balance::split<0x2::sui::SUI>(&mut arg11, (v10 as u64));
                        let v13 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&v12));
                        let (v14, v15) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v12, v13, arg13);
                        let v16 = volo_unstake(arg1, arg2, arg3, v15, arg13);
                        0x2::balance::join<0x2::sui::SUI>(&mut arg11, v16);
                        0x2::balance::join<0x2::sui::SUI>(&mut arg11, v14);
                        break
                    };
                };
                let v17 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&arg11));
                if (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg1, arg2, v17) < 1000000000) {
                    break
                };
                let v18 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg11);
                let v19 = get_withdraw_amt(arg0, arg1, arg2, arg5, 0x2::balance::value<0x2::sui::SUI>(&v18));
                let (v20, v21) = navi_repay_and_withdraw_collateral(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v18, v19, arg13);
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, volo_unstake(arg1, arg2, arg3, v21, arg13));
                0x2::balance::join<0x2::sui::SUI>(&mut arg11, v20);
                if (0x2::balance::value<0x2::sui::SUI>(&arg11) >= arg12) {
                    break
                };
            };
        };
        arg11
    }

    entry fun set_borrow_bias(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: u64) {
        arg0.bias.borrow_bias_bps = arg2;
    }

    entry fun set_put_back_bias(arg0: &mut Strategy, arg1: u64) {
        arg0.bias.put_back_bias_bps = arg1;
    }

    public fun skim_base_profits(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
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

    public fun skim_base_profits_with_incentive_v3(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        assert_if_version_not_matched(arg0);
        let (v0, v1) = navi_claim_rewards_with_incentive_v3(arg0, arg2, arg3, arg4, arg5, arg6);
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

    public fun take_all_asset_for_selling(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg13: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg14: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg15: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg16: address, arg17: address, arg18: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg19: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg20: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, arg21: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, 0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
        assert_if_version_not_matched(arg0);
        let v0 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v0);
        let v2 = borrow_collected_asset_mut<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0);
        let v3 = 0x2::balance::withdraw_all<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v2);
        let v4 = borrow_collected_asset_mut<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(arg0);
        let v5 = 0x2::balance::withdraw_all<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(v4);
        let (v6, v7) = navi_claim_rewards_with_incentive_v3(arg0, arg5, arg6, arg10, arg19, arg20);
        0x2::balance::join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&mut v3, v6);
        0x2::balance::join<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&mut v5, v7);
        let v8 = (0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg6, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256);
        let v9 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg6, 0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap));
        if ((v8 as u64) >= 1000000000) {
            let (v10, v11) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_borrow<0x2::sui::SUI>(arg18, (0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v9, (10000 as u256), ((10000 + 5) as u256)) as u64));
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v10);
            let v12 = revolving_repay_and_withdraw(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1), (v8 as u64), arg21);
            0x2::balance::join<0x2::sui::SUI>(&mut v1, v12);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::flash_repay<0x2::sui::SUI>(arg18, 0x2::balance::split<0x2::sui::SUI>(&mut v1, (v9 as u64)), v11);
        };
        add_to_collected_asset<0x2::sui::SUI>(arg0, v1);
        let v13 = 0x2::balance::value<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>(&v5);
        let v14 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3);
        let v15 = get_price(arg5, arg12, arg11, arg13, arg15, arg17, 7);
        let v16 = TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>{
            take_amt    : v13,
            sui_est_amt : (0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v15, (v13 as u256), get_price(arg5, arg12, arg11, arg13, arg14, arg16, 0)) as u64),
        };
        let v17 = TakeAssetReceipt<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>{
            take_amt    : v14,
            sui_est_amt : 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg2, arg3, v14),
        };
        (v3, v5, v17, v16)
    }

    public fun take_profits_for_selling(arg0: &mut Strategy, arg1: &0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::AdminCap<0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: address, arg12: address, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>, TakeAssetReceipt<0xa99b8952d4f7d947ea77fe0ecdcc9e5fc0bcab2841d6e2a5aa00c3044e5544b5::navx::NAVX>) {
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
            sui_est_amt : (0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::utils::u256_mul_div(v4, (v3 as u256), get_price(arg5, arg6, arg7, arg8, arg9, arg11, 0)) as u64),
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

    public fun withdraw(arg0: &mut Strategy, arg1: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::Vault<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg2: &mut 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::WithdrawTicket<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg4: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg12: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg13: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg14: &mut 0x2::tx_context::TxContext) {
        assert_if_version_not_matched(arg0);
        let v0 = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::withdraw_ticket_to_withdraw<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg2, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access));
        if (v0 > 0) {
            let v1 = borrow_collected_asset_mut<0x2::sui::SUI>(arg0);
            let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(v1);
            if (0x2::balance::value<0x2::sui::SUI>(&v2) >= v0) {
                0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg2, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::split<0x2::sui::SUI>(&mut v2, v0));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v2);
            } else {
                let v3 = 0x2::balance::value<0x2::sui::SUI>(0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::free_balance<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1));
                assert!(((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::from_shares(arg3, arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg7, 5, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_cap)) as u64)) as u256) as u64) >= 1000000000, 107);
                let v4 = calculate_required_sui_for_repay(arg0, arg3, arg4, arg7, 1000000000);
                assert!(v3 >= v4, 111111111);
                let (v5, v6) = 0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::flash_loan<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), v3);
                0x2::balance::join<0x2::sui::SUI>(&mut v2, v5);
                let v7 = v0 + v3;
                let v8 = v7;
                if (v7 < 1000000000) {
                    v8 = 1000000000;
                };
                0x2::balance::join<0x2::sui::SUI>(&mut v2, revolving_repay_and_withdraw(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v2), v8, arg14));
                0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::repay_flash_loan<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg1, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), v6, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
                0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::strategy_withdraw_to_ticket<0x2::sui::SUI, 0xce80cda09166c6599b80655925c98301c957738b1fe2a7fbf8958286533f35e6::st_sui::ST_SUI>(arg2, 0x1::option::borrow<0x42fadd773836e6c04efb974f49ac94c74969b1c838137a91ead08ed9ced4db1a::vault::VaultAccess>(&arg0.vault_access), 0x2::balance::split<0x2::sui::SUI>(&mut v2, 0x1::u64::min(v0, 0x2::balance::value<0x2::sui::SUI>(&v2))));
                add_to_collected_asset<0x2::sui::SUI>(arg0, v2);
            };
        };
        let v9 = WithdrawEvent{redeem_amt: v0};
        0x2::event::emit<WithdrawEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

