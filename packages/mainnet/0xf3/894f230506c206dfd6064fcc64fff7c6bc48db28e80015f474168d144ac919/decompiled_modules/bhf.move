module 0xf3894f230506c206dfd6064fcc64fff7c6bc48db28e80015f474168d144ac919::bhf {
    struct BHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHF>(arg0, 6, b"BHF", b"BlueHyperfart", b"Worlds fastest fart combined with Worlds fastest tech. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734533460282.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

