module 0x6c3641164e876aea18b84be5e491793edb51423698c8866f3a956789d0b52b8a::memey {
    struct MEMEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEY>(arg0, 6, b"MEMEY", b"Memey Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEMEY>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

