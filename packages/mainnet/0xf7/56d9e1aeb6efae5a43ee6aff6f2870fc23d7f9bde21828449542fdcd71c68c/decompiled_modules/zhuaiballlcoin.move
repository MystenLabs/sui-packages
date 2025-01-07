module 0xf756d9e1aeb6efae5a43ee6aff6f2870fc23d7f9bde21828449542fdcd71c68c::zhuaiballlcoin {
    struct ZHUAIBALLLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHUAIBALLLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHUAIBALLLCOIN>(arg0, 18, b"ZBC", b"Zbc", b"ZBC is zhuaiballl's coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHUAIBALLLCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHUAIBALLLCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

