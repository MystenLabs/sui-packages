module 0x70eba79fb88d2e44dea4ef40f061bd3a00fd131f7aea2c1ec484e88ad9da7b0c::void {
    struct VOID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOID>(arg0, 9, b"VOID", b"TheVoid", b"VOID has a unique burn mechanism without any taxes that operates on a timer. It burns a static 1% from its VOID/ETH liquidity pool, burning all of the sell-side liquidity (VOID) and keeping all of the buy-side liquidity (SUI) to be used in creating additional liquidity pools with other blue-chip tokens on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x21eceaf3bf88ef0797e3927d855ca5bb569a47fc.png?size=xl&key=34c350")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VOID>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOID>>(v1);
    }

    // decompiled from Move bytecode v6
}

