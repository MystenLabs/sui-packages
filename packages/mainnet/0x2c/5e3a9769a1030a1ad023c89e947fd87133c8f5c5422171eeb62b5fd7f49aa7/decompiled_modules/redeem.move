module 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::redeem {
    struct RedeemEvent has copy, drop {
        redeemer: address,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        burn_asset: 0x1::type_name::TypeName,
        burn_amount: u64,
        time: u64,
    }

    public fun redeem<T0>(arg0: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::Version, arg1: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::Market, arg2: 0x2::coin::Coin<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::assert_current_version(arg0);
        assert!(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::whitelist::is_address_allowed(0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::uid(arg1), 0x2::tx_context::sender(arg4)), 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::error::whitelist_error());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::handle_redeem<T0>(arg1, 0x2::coin::into_balance<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::reserve::MarketCoin<T0>>(arg2), v0);
        let v2 = RedeemEvent{
            redeemer        : 0x2::tx_context::sender(arg4),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v1),
            burn_asset      : 0x1::type_name::get<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::reserve::MarketCoin<T0>>(),
            burn_amount     : 0x2::coin::value<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::reserve::MarketCoin<T0>>(&arg2),
            time            : v0,
        };
        0x2::event::emit<RedeemEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public entry fun redeem_entry<T0>(arg0: &0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::version::Version, arg1: &mut 0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::market::Market, arg2: 0x2::coin::Coin<0x2c5e3a9769a1030a1ad023c89e947fd87133c8f5c5422171eeb62b5fd7f49aa7::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

