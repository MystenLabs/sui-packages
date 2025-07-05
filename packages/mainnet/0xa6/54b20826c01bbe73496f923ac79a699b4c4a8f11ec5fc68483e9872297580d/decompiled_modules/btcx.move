module 0xa654b20826c01bbe73496f923ac79a699b4c4a8f11ec5fc68483e9872297580d::btcx {
    struct BTCX has drop {
        dummy_field: bool,
    }

    struct BTCXTreasuryCoinfig has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<BTCX>,
    }

    public fun burn_xstock(arg0: &mut BTCXTreasuryCoinfig, arg1: 0x2::coin::Coin<BTCX>) {
        0x2::coin::burn<BTCX>(&mut arg0.treasuryCap, arg1);
    }

    public fun buy(arg0: &mut BTCXTreasuryCoinfig, arg1: &mut 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::config::Config, arg2: &mut 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::treasury::Treasury, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<BTCX>, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let (v0, v1, v2) = 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::trade::buy_stock<BTCX>(arg1, arg2, arg3, arg4, arg5, arg6);
        (v0, v1, 0x2::coin::mint<BTCX>(&mut arg0.treasuryCap, v1, arg6), v2)
    }

    fun init(arg0: BTCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCX>(arg0, 5, b"BTCx", b"Bitcoin Token", b"Tokenized Bitcoin representing fractional ownership of BTC (backed by Bitcoin reserves)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/btcx.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCX>>(v1);
        let v2 = BTCXTreasuryCoinfig{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
        };
        0x2::transfer::public_share_object<BTCXTreasuryCoinfig>(v2);
    }

    public fun sell(arg0: &mut 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::config::Config, arg1: &mut 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::treasury::Treasury, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<BTCX>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::trade::sell_stock<BTCX>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

