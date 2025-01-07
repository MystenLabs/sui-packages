module 0xe2995b8528950651d7fb429b3617547325ba3527f279fcadc0b4fc2b4961012a::memek_ani {
    struct MEMEK_ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ANI>(arg0, 6, b"MEMEKANI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ANI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ANI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ANI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

