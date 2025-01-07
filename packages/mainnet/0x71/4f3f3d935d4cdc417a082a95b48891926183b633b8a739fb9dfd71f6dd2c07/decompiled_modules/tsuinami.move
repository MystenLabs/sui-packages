module 0x714f3f3d935d4cdc417a082a95b48891926183b633b8a739fb9dfd71f6dd2c07::tsuinami {
    struct TSUINAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUINAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUINAMI>(arg0, 6, b"TSUINAMI", b"The Gigantic TSUNAMI of SUI", b"$TSUINAMI is a tidal wave of potential on Sui. Like a tsunami, it builds unstoppable momentum, crashing into the Sui world with immense power. Holders of $TSUINAMI can ride the wave and capitalize on its massive impact!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TSUINAMI_e914cd5310.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUINAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUINAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

