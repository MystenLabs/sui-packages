module 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::redeem {
    struct RedeemEvent has copy, drop {
        redeemer: address,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        burn_asset: 0x1::type_name::TypeName,
        burn_amount: u64,
        time: u64,
    }

    public fun redeem<T0>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg2: 0x2::coin::Coin<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::assert_current_version(arg0);
        assert!(0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::is_address_allowed(0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::whitelist_error());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::handle_redeem<T0>(arg1, 0x2::coin::into_balance<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::MarketCoin<T0>>(arg2), v0);
        let v2 = RedeemEvent{
            redeemer        : 0x2::tx_context::sender(arg4),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v1),
            burn_asset      : 0x1::type_name::get<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::MarketCoin<T0>>(),
            burn_amount     : 0x2::coin::value<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::MarketCoin<T0>>(&arg2),
            time            : v0,
        };
        0x2::event::emit<RedeemEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun redeem_entry<T0>(arg0: &0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::version::Version, arg1: &mut 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::market::Market, arg2: 0x2::coin::Coin<0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

