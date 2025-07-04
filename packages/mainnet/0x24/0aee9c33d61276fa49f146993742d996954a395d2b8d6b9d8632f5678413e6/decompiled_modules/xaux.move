module 0x240aee9c33d61276fa49f146993742d996954a395d2b8d6b9d8632f5678413e6::xaux {
    struct XAUX has drop {
        dummy_field: bool,
    }

    struct XAUXTreasuryCoinfig has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<XAUX>,
    }

    public fun buy(arg0: &mut XAUXTreasuryCoinfig, arg1: &mut 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::config::Config, arg2: &mut 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::treasury::Treasury, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<XAUX>, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        (0x2::coin::mint<XAUX>(&mut arg0.treasuryCap, arg4, arg7), 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::trade::buy_stock<XAUX>(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun init(arg0: XAUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUX>(arg0, 5, b"NVDAx", b"NVIDIA Tokenized Stock", b"NVIDIA Tokenized Stock representing fractional shares of NVDA (Nasdaq)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/xaux.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAUX>>(v1);
        let v2 = XAUXTreasuryCoinfig{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
        };
        0x2::transfer::public_share_object<XAUXTreasuryCoinfig>(v2);
    }

    public fun sell(arg0: &mut XAUXTreasuryCoinfig, arg1: &mut 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::config::Config, arg2: &mut 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::treasury::Treasury, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<XAUX>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let (v0, v1) = 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::trade::sell_stock<XAUX>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::coin::burn<XAUX>(&mut arg0.treasuryCap, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

