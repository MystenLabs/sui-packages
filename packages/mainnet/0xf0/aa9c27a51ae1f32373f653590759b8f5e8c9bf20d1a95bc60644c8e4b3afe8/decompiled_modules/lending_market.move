module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market {
    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct LendingMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct RateLimiterExemption<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    public fun claim_rewards<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun claim_rewards_and_deposit<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun compound_interest<T0>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        abort 0
    }

    public fun create_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        abort 0
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CToken<T0, T1>> {
        abort 0
    }

    public fun obligation<T0>(arg0: &LendingMarket<T0>, arg1: 0x2::object::ID) : &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::obligation::Obligation<T0> {
        abort 0
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        abort 0
    }

    public fun redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<CToken<T0, T1>>, arg4: 0x1::option::Option<RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun refresh_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        abort 0
    }

    public fun reserve<T0, T1>(arg0: &LendingMarket<T0>) : &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::reserve::Reserve<T0> {
        abort 0
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CToken<T0, T1>> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

