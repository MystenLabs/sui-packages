module 0xe7a7335937afbee4fb066486592c17ae3a4273d01feaa7e20806a8c43fda37fc::organic {
    struct ORGANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGANIC>(arg0, 6, b"Organic", b"Organic Plant", b"No Need to Panic, Pure Organic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735925308942.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORGANIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGANIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

