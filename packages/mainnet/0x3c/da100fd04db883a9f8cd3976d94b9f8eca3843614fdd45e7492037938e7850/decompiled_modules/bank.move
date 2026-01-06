module 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank {
    struct ProtocolFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Bank<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        funds_available: 0x2::balance::Balance<T1>,
        lending: 0x1::option::Option<Lending<T0>>,
        min_token_block_size: u64,
        btoken_supply: 0x2::balance::Supply<T2>,
        version: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::Version,
    }

    struct Lending<phantom T0> has store {
        ctokens: u64,
        target_utilisation_bps: u16,
        utilisation_buffer_bps: u16,
        reserve_array_index: u64,
        obligation_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct NeedsRebalance has copy, drop, store {
        needs_rebalance: bool,
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

    struct BankLiquidityEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        funds_available: u64,
        funds_deployed: u64,
    }

    struct ClaimRewardsEvent<phantom T0, phantom T1> has copy, drop, store {
        bank_id: 0x2::object::ID,
        reward_amount: u64,
        excess_amount: u64,
    }

    struct ClaimAllRewardsEvent has copy, drop, store {
        bank_id: 0x2::object::ID,
        reward_amount: u64,
        auto_deposited_reward_amount: u64,
        reward_type: 0x1::type_name::TypeName,
        underlying_type: 0x1::type_name::TypeName,
    }

    public(friend) fun assert_btoken_type<T0, T1>() {
        let v0 = 0x1::string::utf8(b"B_");
        0x1::string::append(&mut v0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::get_type_reflection<T0>());
        assert!(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::get_type_reflection<T1>() == v0, 0);
    }

    fun btoken_ratio<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        if (0x2::balance::supply_value<T2>(&arg0.btoken_supply) == 0) {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1))
        } else {
            (total_funds<T0, T1, T2>(arg0, arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x2::balance::supply_value<T2>(&arg0.btoken_supply)))
        }
    }

    public fun burn_btoken<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (arg3 == 0) {
            return 0x2::coin::zero<T1>(arg5)
        };
        assert!(0x2::coin::value<T2>(arg2) != 0, 12);
        assert!(0x2::coin::value<T2>(arg2) >= arg3, 13);
        let v0 = 0x2::balance::supply_value<T2>(&arg0.btoken_supply) - arg3;
        if (v0 < 1000) {
            arg3 = arg3 - 1000 - v0;
        };
        assert!(arg3 > 0, 14);
        let v1 = from_btokens<T0, T1, T2>(arg0, arg1, arg3, arg4);
        0x2::balance::decrease_supply<T2>(&mut arg0.btoken_supply, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(arg2, arg3, arg5)));
        assert!(0x2::balance::value<T1>(&arg0.funds_available) >= v1, 9);
        let v2 = 0x2::balance::value<T1>(&arg0.funds_available);
        assert!(v2 + 1 >= v1, 9);
        let v3 = 0x1::u64::min(v1, v2);
        assert!(v3 > 0, 15);
        let v4 = BurnBTokenEvent{
            user              : 0x2::tx_context::sender(arg5),
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            withdrawn_amount  : v3,
            burned_amount     : arg3,
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BurnBTokenEvent>(v4);
        let v5 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            funds_available : 0x2::balance::value<T1>(&arg0.funds_available),
            funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed_<T0, T1, T2>(arg0, arg1, arg4)),
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.funds_available, v3), arg5)
    }

    public fun burn_btokens<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        compound_interest_if_any<T0, T1, T2>(arg0, arg1, arg4);
        let v0 = from_btokens<T0, T1, T2>(arg0, arg1, arg3, arg4);
        if (0x2::balance::value<T1>(&arg0.funds_available) < v0) {
            prepare_for_pending_withdraw<T0, T1, T2>(arg0, arg1, v0, arg4, arg5);
        };
        burn_btoken<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun claim_fees<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFeeKey{dummy_field: false};
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::balance::Balance<T2>>(&mut arg0.id, v0)), arg4);
        let v2 = &mut v1;
        let v3 = burn_btoken<T0, T1, T2>(arg0, arg1, v2, 0x2::coin::value<T2>(&v1), arg3, arg4);
        0x2::coin::destroy_zero<T2>(v1);
        distribute_coins<T1>(v3, arg2, arg4);
    }

    public fun claim_rewards<T0, T1, T2, T3>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        let v1 = 0;
        if (arg3 != 18446744073709551615) {
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg1, &v0.obligation_cap, arg4, v0.reserve_array_index, arg3, true, arg5);
            v1 = 0x2::coin::value<T3>(&v2);
            distribute_coins<T3>(v2, arg2, arg5);
        };
        let v3 = if (0x1::type_name::get<T1>() == 0x1::type_name::get<T3>()) {
            let v4 = sync_obligation_and_bank<T0, T1, T2>(arg0, arg1, arg4, arg5);
            let v5 = 0x2::balance::value<T1>(&v4);
            if (v5 > 0) {
                let v6 = 0x2::coin::from_balance<T1>(v4, arg5);
                distribute_coins<T1>(v6, arg2, arg5);
            } else {
                0x2::balance::destroy_zero<T1>(v4);
            };
            v5
        } else {
            let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T3>(arg1);
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T3>(arg1, v7, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T3>(arg1, v7, &v0.obligation_cap, arg4, 18446744073709551615, arg5), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>(), arg5);
            let v9 = 0x2::coin::value<T3>(&v8);
            if (v9 > 0) {
                distribute_coins<T3>(v8, arg2, arg5);
            } else {
                0x2::coin::destroy_zero<T3>(v8);
            };
            v9
        };
        let v10 = ClaimAllRewardsEvent{
            bank_id                      : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            reward_amount                : v1,
            auto_deposited_reward_amount : v3,
            reward_type                  : 0x1::type_name::get<T3>(),
            underlying_type              : 0x1::type_name::get<T1>(),
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<ClaimAllRewardsEvent>(v10);
    }

    public fun compound_interest_if_any<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<T0>(arg1, reserve_array_index<T0, T1, T2>(arg0), arg2);
        };
    }

    public(friend) fun create_bank<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::coin::CoinMetadata<T2>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x2::tx_context::TxContext) : Bank<T0, T1, T2> {
        assert!(0x2::coin::total_supply<T2>(&arg3) == 0, 2);
        update_btoken_metadata<T1, T2>(arg1, arg2, &arg3);
        let v0 = Bank<T0, T1, T2>{
            id                   : 0x2::object::new(arg5),
            funds_available      : 0x2::balance::zero<T1>(),
            lending              : 0x1::option::none<Lending<T0>>(),
            min_token_block_size : 1000000000,
            btoken_supply        : 0x2::coin::treasury_into_supply<T2>(arg3),
            version              : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::new(1),
        };
        let v1 = NewBankEvent{
            bank_id             : 0x2::object::id<Bank<T0, T1, T2>>(&v0),
            coin_type           : 0x1::type_name::get<T1>(),
            btoken_type         : 0x1::type_name::get<T2>(),
            lending_market_id   : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg4),
            lending_market_type : 0x1::type_name::get<T0>(),
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::register_bank(arg0, v1.bank_id, v1.coin_type, v1.btoken_type, v1.lending_market_id, v1.lending_market_type);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<NewBankEvent>(v1);
        v0
    }

    public entry fun create_bank_and_share<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::coin::CoinMetadata<T2>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_bank<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<Bank<T0, T1, T2>>(v0);
        0x2::object::id<Bank<T0, T1, T2>>(&v0)
    }

    fun ctoken_amount<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), 0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index)))
    }

    public(friend) fun ctoken_ratio<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), 0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index), arg2)
    }

    fun deploy<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        if (arg2 < arg0.min_token_block_size) {
            return
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, v0.reserve_array_index, arg3, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.funds_available, arg2), arg4), arg4);
        let v2 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, v0.reserve_array_index, &v0.obligation_cap, arg3, v1, arg4);
        let v3 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        v3.ctokens = v3.ctokens + v2;
        let v4 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            funds_available : 0x2::balance::value<T1>(&arg0.funds_available),
            funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), v3.reserve_array_index))))),
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v4);
        let v5 = DeployEvent{
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            deployed_amount   : arg2,
            ctokens_minted    : v2,
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<DeployEvent>(v5);
    }

    fun distribute_coins<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::get_fee_receivers(arg1);
        let v2 = 0x1::vector::length<u64>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::fee_weights(v1));
        let v3 = 0;
        while (v3 < v2) {
            let v4 = if (v3 == v2 - 1) {
                0x2::balance::withdraw_all<T0>(&mut v0)
            } else {
                0x2::balance::split<T0>(&mut v0, (((0x2::balance::value<T0>(&v0) as u128) * (*0x1::vector::borrow<u64>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::fee_weights(v1), v3) as u128) / (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::fee_total_weight(v1) as u128)) as u64))
            };
            let v5 = v4;
            if (0x2::balance::value<T0>(&v5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), *0x1::vector::borrow<address>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::fee_receivers(v1), v3));
            } else {
                0x2::balance::destroy_zero<T0>(v5);
            };
            v3 = v3 + 1;
        };
        0x2::balance::destroy_zero<T0>(v0);
    }

    public(friend) fun effective_utilisation_bps<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: u64) : u64 {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_utilisation_bps(0x2::balance::value<T1>(&arg0.funds_available), arg1)
    }

    public fun from_btokens<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            let (v1, v2) = btoken_ratio<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg3)));
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), v1), v2))
        } else {
            arg2
        }
    }

    public fun funds_available<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : &0x2::balance::Balance<T1> {
        &arg0.funds_available
    }

    public(friend) fun funds_deployed<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            assert!(0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(&arg1), 8);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::option::borrow<Lending<T0>>(&arg0.lending).ctokens), *0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(&arg1))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        }
    }

    fun funds_deployed_<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::option::borrow<Lending<T0>>(&arg0.lending).ctokens), ctoken_ratio<T0, T1, T2>(arg0, arg1, arg2))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)
        }
    }

    public(friend) fun get_btoken_ratio<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            btoken_ratio<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg2)))
        } else {
            (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1))
        }
    }

    public fun init_lending<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u16, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x1::option::is_none<Lending<T0>>(&arg0.lending), 5);
        assert!(arg3 + arg4 <= 10000, 3);
        assert!(arg3 >= arg4, 4);
        let v0 = Lending<T0>{
            ctokens                : 0,
            target_utilisation_bps : arg3,
            utilisation_buffer_bps : arg4,
            reserve_array_index    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg2),
            obligation_cap         : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg5),
        };
        0x1::option::fill<Lending<T0>>(&mut arg0.lending, v0);
    }

    public fun lending<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : &0x1::option::Option<Lending<T0>> {
        &arg0.lending
    }

    entry fun migrate<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::migrate_(&mut arg0.version, 1);
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun mint_btoken<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x2::balance::supply_value<T2>(&arg0.btoken_supply) == 0) {
            assert!(arg3 > 1000, 16);
        } else {
            assert!(arg3 > 0, 11);
        };
        assert!(0x2::coin::value<T1>(arg2) >= arg3, 10);
        let v0 = to_btokens<T0, T1, T2>(arg0, arg1, arg3, arg4);
        let v1 = MintBTokenEvent{
            user              : 0x2::tx_context::sender(arg5),
            bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
            deposited_amount  : arg3,
            minted_amount     : v0,
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<MintBTokenEvent>(v1);
        0x2::balance::join<T1>(&mut arg0.funds_available, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, arg3, arg5)));
        let v2 = BankLiquidityEvent{
            bank_id         : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
            funds_available : 0x2::balance::value<T1>(&arg0.funds_available),
            funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed_<T0, T1, T2>(arg0, arg1, arg4)),
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v2);
        0x2::coin::from_balance<T2>(0x2::balance::increase_supply<T2>(&mut arg0.btoken_supply, v0), arg5)
    }

    public fun mint_btokens<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        mint_btoken<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun move_fees<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = ProtocolFeeKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ProtocolFeeKey>(&arg0.id, v0)) {
            let v1 = ProtocolFeeKey{dummy_field: false};
            0x2::dynamic_field::add<ProtocolFeeKey, 0x2::balance::Balance<T2>>(&mut arg0.id, v1, 0x2::balance::zero<T2>());
        };
        let v2 = ProtocolFeeKey{dummy_field: false};
        0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<ProtocolFeeKey, 0x2::balance::Balance<T2>>(&mut arg0.id, v2), arg1);
    }

    public fun needs_rebalance<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : NeedsRebalance {
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return NeedsRebalance{needs_rebalance: false}
        };
        let v0 = effective_utilisation_bps<T0, T1, T2>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg2)))));
        let v1 = target_utilisation_bps_unchecked<T0, T1, T2>(arg0);
        let v2 = utilisation_buffer_bps_unchecked<T0, T1, T2>(arg0);
        let v3 = v0 <= v1 + v2 && v0 >= v1 - v2 && false || true;
        NeedsRebalance{needs_rebalance: v3}
    }

    public(friend) fun prepare_for_pending_withdraw<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return
        };
        let v0 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_recall_for_pending_withdraw(0x2::balance::value<T1>(&arg0.funds_available), arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg3)))), (v0.target_utilisation_bps as u64), (v0.utilisation_buffer_bps as u64));
        let v2 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
        if (v1 == 0) {
        } else {
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v2.reserve_array_index, &v2.obligation_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(ctoken_amount<T0, T1, T2>(arg0, arg1, 0x1::u64::max(v1, arg0.min_token_block_size))), arg4);
            let v4 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v3);
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v2.reserve_array_index, arg3, v3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
            let v6 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
            v6.ctokens = v6.ctokens - v4;
            0x2::balance::join<T1>(&mut arg0.funds_available, 0x2::coin::into_balance<T1>(v5));
            let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), v6.reserve_array_index));
            assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v6.ctokens), v7)) >= 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v7))), 6);
            let v8 = BankLiquidityEvent{
                bank_id         : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
                funds_available : 0x2::balance::value<T1>(&arg0.funds_available),
                funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v7))),
            };
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v8);
            let v9 = RecallEvent{
                bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
                lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
                recalled_amount   : 0x2::coin::value<T1>(&v5),
                ctokens_burned    : v4,
            };
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<RecallEvent>(v9);
        };
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        compound_interest_if_any<T0, T1, T2>(arg0, arg1, arg2);
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return
        };
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg2))));
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_utilisation_bps(0x2::balance::value<T1>(&arg0.funds_available), v0);
        let v2 = target_utilisation_bps_unchecked<T0, T1, T2>(arg0);
        let v3 = utilisation_buffer_bps<T0, T1, T2>(arg0);
        if (v1 < v2 - v3) {
            let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_amount_to_deploy(0x2::balance::value<T1>(&arg0.funds_available), v0, v2);
            deploy<T0, T1, T2>(arg0, arg1, v4, arg2, arg3);
        } else if (v1 > v2 + v3) {
            let v5 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_amount_to_recall(0x2::balance::value<T1>(&arg0.funds_available), 0, v0, v2);
            let v6 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
            if (v5 == 0) {
            } else {
                let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v6.reserve_array_index, &v6.obligation_cap, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(ctoken_amount<T0, T1, T2>(arg0, arg1, 0x1::u64::max(v5, arg0.min_token_block_size))), arg3);
                let v8 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v7);
                let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v6.reserve_array_index, arg2, v7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3);
                let v10 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
                v10.ctokens = v10.ctokens - v8;
                0x2::balance::join<T1>(&mut arg0.funds_available, 0x2::coin::into_balance<T1>(v9));
                let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), v10.reserve_array_index));
                assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v10.ctokens), v11)) >= 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v11))), 6);
                let v12 = BankLiquidityEvent{
                    bank_id         : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
                    funds_available : 0x2::balance::value<T1>(&arg0.funds_available),
                    funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v11))),
                };
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v12);
                let v13 = RecallEvent{
                    bank_id           : 0x2::object::id<Bank<T0, T1, T2>>(arg0),
                    lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
                    recalled_amount   : 0x2::coin::value<T1>(&v9),
                    ctokens_burned    : v8,
                };
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<RecallEvent>(v13);
            };
        };
    }

    public fun rebalance_sui<T0, T1>(arg0: &mut Bank<T0, 0x2::sui::SUI, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        compound_interest_if_any<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg3);
        if (0x1::option::is_none<Lending<T0>>(&arg0.lending)) {
            return
        };
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, 0x2::sui::SUI, T1>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg3))));
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_utilisation_bps(0x2::balance::value<0x2::sui::SUI>(&arg0.funds_available), v0);
        let v2 = target_utilisation_bps_unchecked<T0, 0x2::sui::SUI, T1>(arg0);
        let v3 = utilisation_buffer_bps<T0, 0x2::sui::SUI, T1>(arg0);
        if (v1 < v2 - v3) {
            let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_amount_to_deploy(0x2::balance::value<0x2::sui::SUI>(&arg0.funds_available), v0, v2);
            deploy<T0, 0x2::sui::SUI, T1>(arg0, arg1, v4, arg3, arg4);
        } else if (v1 > v2 + v3) {
            let v5 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank_math::compute_amount_to_recall(0x2::balance::value<0x2::sui::SUI>(&arg0.funds_available), 0, v0, v2);
            let v6 = 0x1::option::borrow<Lending<T0>>(&arg0.lending);
            if (v5 == 0) {
            } else {
                let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, v6.reserve_array_index, &v6.obligation_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(ctoken_amount<T0, 0x2::sui::SUI, T1>(arg0, arg1, 0x1::u64::max(v5, arg0.min_token_block_size))), arg4);
                let v8 = 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, 0x2::sui::SUI>>(&v7);
                let v9 = v6.reserve_array_index;
                let v10 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, v9, arg3, v7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg4);
                0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, v9, &v10, arg2, arg4);
                let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, v9, v10, arg4);
                let v12 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
                v12.ctokens = v12.ctokens - v8;
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds_available, 0x2::coin::into_balance<0x2::sui::SUI>(v11));
                let v13 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), v12.reserve_array_index));
                assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v12.ctokens), v13)) >= 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, 0x2::sui::SUI, T1>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v13))), 6);
                let v14 = BankLiquidityEvent{
                    bank_id         : 0x2::object::id<Bank<T0, 0x2::sui::SUI, T1>>(arg0),
                    funds_available : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds_available),
                    funds_deployed  : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(funds_deployed<T0, 0x2::sui::SUI, T1>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v13))),
                };
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<BankLiquidityEvent>(v14);
                let v15 = RecallEvent{
                    bank_id           : 0x2::object::id<Bank<T0, 0x2::sui::SUI, T1>>(arg0),
                    lending_market_id : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1),
                    recalled_amount   : 0x2::coin::value<0x2::sui::SUI>(&v11),
                    ctokens_burned    : v8,
                };
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<RecallEvent>(v15);
            };
        };
    }

    public fun reserve_array_index<T0, T1, T2>(arg0: &Bank<T0, T1, T2>) : u64 {
        0x1::option::borrow<Lending<T0>>(&arg0.lending).reserve_array_index
    }

    public fun set_min_token_block_size<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin, arg2: u64) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        arg0.min_token_block_size = arg2;
    }

    public fun set_utilisation_bps<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin, arg2: u16, arg3: u16) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut arg0.version, 1);
        assert!(0x1::option::is_some<Lending<T0>>(&arg0.lending), 7);
        assert!(arg2 + arg3 <= 10000, 3);
        assert!(arg2 >= arg3, 4);
        let v0 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        v0.target_utilisation_bps = arg2;
        v0.utilisation_buffer_bps = arg3;
    }

    fun sync_obligation_and_bank<T0, T1, T2>(arg0: &mut Bank<T0, T1, T2>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::option::borrow_mut<Lending<T0>>(&mut arg0.lending);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0.obligation_cap)));
        let v2 = v0.ctokens;
        if (v1 > v2) {
            0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v0.reserve_array_index, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v0.reserve_array_index, &v0.obligation_cap, arg2, v1 - v2, arg3), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg3))
        } else {
            0x2::balance::zero<T1>()
        }
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

    public fun to_btokens<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (0x1::option::is_some<Lending<T0>>(&arg0.lending)) {
            let (v1, v2) = btoken_ratio<T0, T1, T2>(arg0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(ctoken_ratio<T0, T1, T2>(arg0, arg1, arg3)));
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), v2), v1))
        } else {
            arg2
        }
    }

    public(friend) fun total_funds<T0, T1, T2>(arg0: &Bank<T0, T1, T2>, arg1: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(funds_deployed<T0, T1, T2>(arg0, arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x2::balance::value<T1>(&arg0.funds_available)))
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
        0x2::coin::update_icon_url<T1>(arg2, arg1, 0x1::ascii::string(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg"));
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

