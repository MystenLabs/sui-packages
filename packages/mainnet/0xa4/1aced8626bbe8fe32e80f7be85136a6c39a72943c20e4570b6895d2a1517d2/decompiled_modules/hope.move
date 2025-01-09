module 0xa41aced8626bbe8fe32e80f7be85136a6c39a72943c20e4570b6895d2a1517d2::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 6, b"HOPE", b"I Live In My Car", b"I am a 32 year olf father of 2 boys. I have a wife and thankfully they are staying with my in laws. they happen to have a 1 bed room apt though . I was evicted by my own blood relatives. This comes after the loss of my mother and other love ones ... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736432954800.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

