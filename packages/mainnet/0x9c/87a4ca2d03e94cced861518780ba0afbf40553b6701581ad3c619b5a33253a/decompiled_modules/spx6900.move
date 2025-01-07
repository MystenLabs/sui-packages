module 0x9c87a4ca2d03e94cced861518780ba0afbf40553b6701581ad3c619b5a33253a::spx6900 {
    struct SPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX6900>(arg0, 6, b"SPX6900", b"SPX 6900 on Sui", b"Welcome to SPX 6900 on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731501423032.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX6900>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6900>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

