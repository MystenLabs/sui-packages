module 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank {
    struct Bank<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        funds_available: 0x2::balance::Balance<T1>,
        lending: 0x1::option::Option<Lending<T0>>,
        min_token_block_size: u64,
        btoken_supply: 0x2::balance::Supply<T2>,
        version: 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::Version,
    }

    struct Lending<phantom T0> has store {
        ctokens: u64,
        target_utilisation_bps: u16,
        utilisation_buffer_bps: u16,
        reserve_array_index: u64,
        obligation_cap: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::ObligationOwnerCap<T0>,
    }

    struct NewBankEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        btoken_type: 0x1::type_name::TypeName,
        lending_market_id: 0x2::object::ID,
        lending_market_type: 0x1::type_name::TypeName,
    }

    struct MintBTokenEvent has copy, drop, store {
        user: address,
        bank_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        deposited_amount: u64,
        minted_amount: u64,
    }

    struct BurnBTokenEvent has copy, drop, store {
        user: address,
        bank_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        withdrawn_amount: u64,
        burned_amount: u64,
    }

    struct DeployEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        deployed_amount: u64,
        ctokens_minted: u64,
    }

    struct RecallEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        recalled_amount: u64,
        ctokens_burned: u64,
    }

    struct NeedsRebalance has copy, drop, store {
        needs_rebalance: bool,
    }

    public fun reserve_array_index<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index
    }

    public(friend) fun assert_btoken_type<T0, T1>() {
        let v0 = 0x1::string::utf8(b"B_");
        0x1::string::append(&mut v0, 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::utils::get_type_reflection<T0>());
        assert!(0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::utils::get_type_reflection<T1>() == v0, 0);
    }

    fun btoken_ratio<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal) {
        if (0x2::balance::supply_value<T2>(&arg0.btoken_supply) == 0) {
            (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(1))
        } else {
            (total_funds<T0, T1, T2>(arg0, arg1, arg2), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::supply_value<T2>(&arg0.btoken_supply)))
        }
    }

    public fun burn_btokens<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        compound_interest_if_any<T0, T1, T2>(arg0, arg1, arg4);
        assert!(0x2::coin::value<T2>(arg2) != 0, 12);
        assert!(0x2::coin::value<T2>(arg2) >= arg3, 13);
        let v0 = 0x2::balance::supply_value<T2>(&arg0.btoken_supply) - arg3;
        if (v0 < 1000) {
            arg3 = arg3 - 1000 - v0;
        };
        assert!(arg3 > 0, 14);
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(from_btokens<T0, T1, T2>(arg0, arg1, arg3, arg4));
        0x2::balance::decrease_supply<T2>(&mut arg0.btoken_supply, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg2, arg3, arg5)));
        if (0x2::balance::value<T1>(&arg0.funds_available) < v1) {
            prepare_for_pending_withdraw<T0, T1, T2>(arg0, arg1, v1, arg4, arg5);
        };
        let v2 = 0x2::balance::value<T1>(&arg0.funds_available);
        assert!(v2 + 1 >= v1, 9);
        let v3 = 0x1::u64::min(v1, v2);
        assert!(v3 > 0, 15);
        let v4 = BurnBTokenEvent{
            user              : 0x2::tx_context::sender(arg5),
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1),
            withdrawn_amount  : v3,
            burned_amount     : arg3,
        };
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::events::emit_event<BurnBTokenEvent>(v4);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.funds_available, v3), arg5)
    }

    public(friend) fun compound_interest_if_any<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::compound_interest<T0>(arg1, reserve_array_index<T0, T1, T2>(arg0), arg2);
        };
    }

    public fun create_bank<T0, T1, T2: drop>(arg0: &mut 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::registry::Registry, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::coin::CoinMetadata<T2>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: &mut 0x2::tx_context::TxContext) : Bank<T0, T1, T2> {
        assert!(0x2::coin::total_supply<T2>(&arg3) == 0, 2);
        update_btoken_metadata<T1, T2>(arg1, arg2, &arg3);
        let v0 = Bank<T0, T1, T2>{
            id                   : 0x2::object::new(arg5),
            funds_available      : 0x2::balance::zero<T1>(),
            lending              : 0x1::option::none<Lending<T0>>(),
            min_token_block_size : 1000000000,
            btoken_supply        : 0x2::coin::treasury_into_supply<T2>(arg3),
            version              : 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::new(1),
        };
        let v1 = NewBankEvent{
            bank_id             : 0x2::object::id<Bank<T0, T1, T2>>(&v0),
            coin_type           : 0x1::type_name::get<T1>(),
            btoken_type         : 0x1::type_name::get<T2>(),
            lending_market_id   : 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg4),
            lending_market_type : 0x1::type_name::get<T0>(),
        };
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::registry::register_bank(arg0, v1.bank_id, v1.coin_type, v1.btoken_type, v1.lending_market_id, v1.lending_market_type);
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::events::emit_event<NewBankEvent>(v1);
        v0
    }

    public entry fun create_bank_and_share<T0, T1, T2: drop>(arg0: &mut 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::registry::Registry, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::coin::CoinMetadata<T2>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_bank<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<Bank<T0, T1, T2>>(v0);
        0x2::object::id<Bank<T0, T1, T2>>(&v0)
    }

    fun ctoken_amount<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg2), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserves<T0>(arg1), 0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index)))
    }

    fun deploy<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        if (arg2 < arg0.min_token_block_size) {
            return
        };
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, v0.reserve_array_index, arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.funds_available, arg2), arg4), arg4);
        let v2 = 0x2::coin::value<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::CToken<T0, T1>>(&v1);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, v0.reserve_array_index, &v0.obligation_cap, arg3, v1, arg4);
        let v3 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        v3.ctokens = v3.ctokens + v2;
        let v4 = DeployEvent{
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1),
            deployed_amount   : arg2,
            ctokens_minted    : v2,
        };
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::events::emit_event<DeployEvent>(v4);
    }

    public(friend) fun effective_utilisation_bps<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank_math::compute_utilisation_bps(0x2::balance::value<T1>(&arg0.funds_available), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(funds_deployed<T0, T1, T2>(arg0, arg1, arg2)))
    }

    public(friend) fun from_btokens<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        let (v0, v1) = btoken_ratio<T0, T1, T2>(arg0, arg1, arg3);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg2), v0), v1)
    }

    public fun funds_available<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.funds_available
    }

    public(friend) fun funds_deployed<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            let v1 = 0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserves<T0>(arg1), reserve_array_index<T0, T1, T2>(arg0));
            assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::interest_last_update_timestamp_s<T0>(v1) == 0x2::clock::timestamp_ms(arg2) / 1000, 8);
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x1::option::borrow<Lending<T0>>(&arg0.lending).ctokens), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_ratio<T0>(v1))
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0)
        }
    }

    public fun init_lending<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::global_admin::GlobalAdmin, arg2: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: u16, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x1::option::is_none<Lending<T0>>(&arg0.lending), 5);
        assert!(arg3 + arg4 <= 10000, 3);
        assert!(arg3 >= arg4, 4);
        let v0 = Lending<T0>{
            ctokens                : 0,
            target_utilisation_bps : arg3,
            utilisation_buffer_bps : arg4,
            reserve_array_index    : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserve_array_index<T0, T1>(arg2),
            obligation_cap         : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::create_obligation<T0>(arg2, arg5),
        };
        0x1::option::fill<Lending<T0>>(&mut arg0.lending, v0);
    }

    public fun lending<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : &0x1::option::Option<Lending<T0>> {
        &arg0.lending
    }

    entry fun migrate<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::global_admin::GlobalAdmin) {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::migrate_(&mut arg0.version, 1);
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun mint_btokens<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x2::balance::supply_value<T2>(&arg0.btoken_supply) == 0) {
            assert!(arg3 > 1000, 16);
        } else {
            assert!(arg3 > 0, 11);
        };
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 10);
        compound_interest_if_any<T0, T1, T2>(arg0, arg1, arg4);
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(to_btokens<T0, T1, T2>(arg0, arg1, arg3, arg4));
        let v1 = MintBTokenEvent{
            user              : 0x2::tx_context::sender(arg5),
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1),
            deposited_amount  : arg3,
            minted_amount     : v0,
        };
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::events::emit_event<MintBTokenEvent>(v1);
        0x2::balance::join<T1>(&mut arg0.funds_available, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, arg3, arg5)));
        0x2::coin::from_balance<T2>(0x2::balance::increase_supply<T2>(&mut arg0.btoken_supply, v0), arg5)
    }

    public fun needs_rebalance<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : NeedsRebalance {
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return NeedsRebalance{needs_rebalance: false}
        };
        let v0 = effective_utilisation_bps<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = target_utilisation_bps_unchecked<T0, T1, T2>(arg0);
        let v2 = utilisation_buffer_bps_unchecked<T0, T1, T2>(arg0);
        let v3 = v0 <= v1 + v2 && v0 >= v1 - v2 && false || true;
        NeedsRebalance{needs_rebalance: v3}
    }

    public(friend) fun prepare_for_pending_withdraw<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return
        };
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        let v1 = 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank_math::compute_recall_for_pending_withdraw(0x2::balance::value<T1>(&arg0.funds_available), arg2, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(funds_deployed<T0, T1, T2>(arg0, arg1, arg3)), (v0.target_utilisation_bps as u64), (v0.utilisation_buffer_bps as u64));
        recall<T0, T1, T2>(arg0, arg1, v1, arg3, arg4);
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        compound_interest_if_any<T0, T1, T2>(arg0, arg1, arg2);
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return
        };
        let v0 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(funds_deployed<T0, T1, T2>(arg0, arg1, arg2));
        let v1 = 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank_math::compute_utilisation_bps(0x2::balance::value<T1>(&arg0.funds_available), v0);
        let v2 = target_utilisation_bps_unchecked<T0, T1, T2>(arg0);
        let v3 = utilisation_buffer_bps<T0, T1, T2>(arg0);
        if (v1 < v2 - v3) {
            let v4 = 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank_math::compute_amount_to_deploy(0x2::balance::value<T1>(&arg0.funds_available), v0, v2);
            deploy<T0, T1, T2>(arg0, arg1, v4, arg2, arg3);
        } else if (v1 > v2 + v3) {
            let v5 = 0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::bank_math::compute_amount_to_recall(0x2::balance::value<T1>(&arg0.funds_available), 0, v0, v2);
            recall<T0, T1, T2>(arg0, arg1, v5, arg2, arg3);
        };
    }

    fun recall<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        if (arg2 == 0) {
            return
        };
        let v1 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::withdraw_ctokens<T0, T1>(arg1, v0.reserve_array_index, &v0.obligation_cap, arg3, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::ceil(ctoken_amount<T0, T1, T2>(arg0, arg1, 0x1::u64::max(arg2, arg0.min_token_block_size))), arg4);
        let v2 = 0x2::coin::value<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::CToken<T0, T1>>(&v1);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, 0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index, arg3, v1, 0x1::option::none<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
        let v4 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        v4.ctokens = v4.ctokens - v2;
        0x2::balance::join<T1>(&mut arg0.funds_available, 0x2::coin::into_balance<T1>(v3));
        assert!(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(v4.ctokens), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::reserve::Reserve<T0>>(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::reserves<T0>(arg1), v4.reserve_array_index)))) >= 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(funds_deployed<T0, T1, T2>(arg0, arg1, arg3)), 6);
        let v5 = RecallEvent{
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1),
            recalled_amount   : 0x2::coin::value<T1>(&v3),
            ctokens_burned    : v2,
        };
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::events::emit_event<RecallEvent>(v5);
    }

    public fun set_utilisation_bps<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::global_admin::GlobalAdmin, arg2: u16, arg3: u16) {
        0x2fc0bbc77688f029ef62394e1724b1f6fde540d7b0d609ccd74d2de9610161e2::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x1::option::is_some<Lending<T0>>(&arg0.lending), 7);
        assert!(arg2 + arg3 <= 10000, 3);
        assert!(arg2 >= arg3, 4);
        let v0 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        v0.target_utilisation_bps = arg2;
        v0.utilisation_buffer_bps = arg3;
    }

    public fun target_utilisation_bps<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            target_utilisation_bps_unchecked<T0, T1, T2>(arg0)
        } else {
            0
        }
    }

    public fun target_utilisation_bps_unchecked<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        (0x1::option::borrow<Lending<T0>>(&arg0.lending).target_utilisation_bps as u64)
    }

    public(friend) fun to_btokens<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        let (v0, v1) = btoken_ratio<T0, T1, T2>(arg0, arg1, arg3);
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg2), v1), v0)
    }

    public(friend) fun total_funds<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal {
        0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::add(funds_deployed<T0, T1, T2>(arg0, arg1, arg2), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x2::balance::value<T1>(&arg0.funds_available)))
    }

    fun update_btoken_metadata<T0, T1: drop>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut 0x2::coin::CoinMetadata<T1>, arg2: &0x2::coin::TreasuryCap<T1>) {
        assert_btoken_type<T0, T1>();
        assert!(0x2::coin::get_decimals<T1>(arg1) == 9, 1);
        let v0 = 0x1::string::utf8(b"bToken ");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg0)));
        0x2::coin::update_name<T1>(arg2, arg1, v0);
        let v1 = 0x1::ascii::string(b"b");
        0x1::ascii::append(&mut v1, 0x2::coin::get_symbol<T0>(arg0));
        0x2::coin::update_symbol<T1>(arg2, arg1, v1);
        0x2::coin::update_description<T1>(arg2, arg1, 0x1::string::utf8(b"Steamm bToken"));
        0x2::coin::update_icon_url<T1>(arg2, arg1, 0x1::ascii::string(b"TODO"));
    }

    public fun utilisation_buffer_bps<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            utilisation_buffer_bps_unchecked<T0, T1, T2>(arg0)
        } else {
            0
        }
    }

    public fun utilisation_buffer_bps_unchecked<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        (0x1::option::borrow<Lending<T0>>(&arg0.lending).utilisation_buffer_bps as u64)
    }

    // decompiled from Move bytecode v6
}

