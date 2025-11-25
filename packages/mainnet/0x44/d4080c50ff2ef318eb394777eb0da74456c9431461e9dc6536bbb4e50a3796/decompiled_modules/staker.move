module 0x44d4080c50ff2ef318eb394777eb0da74456c9431461e9dc6536bbb4e50a3796::staker {
    struct StrategyOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        inner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        strategy_type: u8,
    }

    struct CreatedStrategyOwnerCap has copy, drop {
        cap_id: address,
        obligation_id: address,
        strategy_type: u8,
    }

    struct StakerDepositEvent has copy, drop {
        cap_id: address,
        amount: u64,
        ctoken_type: 0x1::type_name::TypeName,
    }

    struct StakerWithdrawEvent has copy, drop {
        cap_id: address,
        amount: u64,
        ctoken_type: 0x1::type_name::TypeName,
    }

    struct StakerRebalanceEvent has copy, drop {
        cap_id: address,
        timestamp: u64,
    }

    struct StakerClaimFeesEvent has copy, drop {
        cap_id: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public entry fun claim_fees<T0, T1>(arg0: &mut StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg1, &arg0.inner_cap, arg2, arg3, arg4, arg5, arg6);
        let v1 = StakerClaimFeesEvent{
            cap_id      : 0x2::object::id_address<StrategyOwnerCap<T0>>(arg0),
            reward_type : 0x1::type_name::get<T1>(),
            amount      : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<StakerClaimFeesEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun collect_fee<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::AdminCap<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::collect_fees<T0>(arg0, arg2, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_strategy_owner_cap<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg2);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v0);
        let v2 = StrategyOwnerCap<T0>{
            id            : 0x2::object::new(arg2),
            inner_cap     : v0,
            strategy_type : arg1,
        };
        let v3 = CreatedStrategyOwnerCap{
            cap_id        : 0x2::object::id_address<StrategyOwnerCap<T0>>(&v2),
            obligation_id : 0x2::object::id_to_address(&v1),
            strategy_type : arg1,
        };
        0x2::event::emit<CreatedStrategyOwnerCap>(v3);
        0x2::transfer::public_transfer<StrategyOwnerCap<T0>>(v2, 0x2::tx_context::sender(arg2));
    }

    public entry fun custom_redeem<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::custom_redeem<T0>(arg0, 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::custom_redeem_request<T0>(arg0, arg1, arg2, arg3), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun deposit<T0>(arg0: &mut StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T0>(arg1, arg2, arg4, arg3, arg5);
        let v1 = StakerDepositEvent{
            cap_id      : 0x2::object::id_address<StrategyOwnerCap<T0>>(arg0),
            amount      : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T0>>(&v0),
            ctoken_type : 0x1::type_name::get<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T0>>(),
        };
        0x2::event::emit<StakerDepositEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T0>>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun mint_lst<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun rebalance<T0>(arg0: &mut StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::compound_interest<T0>(arg1, arg2, arg3);
        let v0 = StakerRebalanceEvent{
            cap_id    : 0x2::object::id_address<StrategyOwnerCap<T0>>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StakerRebalanceEvent>(v0);
    }

    public entry fun redeem_lst<T0: drop>(arg0: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg0, arg2, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw<T0>(arg0: &mut StrategyOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T0>(arg1, arg2, arg4, arg3, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T0>>(), arg5);
        let v1 = StakerWithdrawEvent{
            cap_id      : 0x2::object::id_address<StrategyOwnerCap<T0>>(arg0),
            amount      : 0x2::coin::value<T0>(&v0),
            ctoken_type : 0x1::type_name::get<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T0>>(),
        };
        0x2::event::emit<StakerWithdrawEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

