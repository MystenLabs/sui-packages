module 0x3b6f5f576cc8dd63aa7144971f1dca86223815efdb86893ede6b2838106d9157::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"BLOBS BROTHER", b"BROOOOOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731171106227.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

