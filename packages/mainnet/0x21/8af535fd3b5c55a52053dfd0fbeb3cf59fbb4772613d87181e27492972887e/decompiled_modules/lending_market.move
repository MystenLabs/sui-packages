module 0x218af535fd3b5c55a52053dfd0fbeb3cf59fbb4772613d87181e27492972887e::lending_market {
    struct LendingMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        dummy: vector<u8>,
    }

    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun claim_rewards<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x218af535fd3b5c55a52053dfd0fbeb3cf59fbb4772613d87181e27492972887e::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x218af535fd3b5c55a52053dfd0fbeb3cf59fbb4772613d87181e27492972887e::reserve::CToken<T0, T1>> {
        abort 0
    }

    public fun redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x218af535fd3b5c55a52053dfd0fbeb3cf59fbb4772613d87181e27492972887e::reserve::CToken<T0, T1>>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x218af535fd3b5c55a52053dfd0fbeb3cf59fbb4772613d87181e27492972887e::reserve::CToken<T0, T1>> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

