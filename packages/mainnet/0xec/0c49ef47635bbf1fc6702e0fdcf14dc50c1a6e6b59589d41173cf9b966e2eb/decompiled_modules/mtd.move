module 0xec0c49ef47635bbf1fc6702e0fdcf14dc50c1a6e6b59589d41173cf9b966e2eb::mtd {
    struct MTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTD>(arg0, 6, b"MTD", b"Maple the Dachshund", b"Our beloved Maple is 1 year old today, so I thought I'd launch a meme to celebrate and in her honour, may she live on forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732321147347.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

