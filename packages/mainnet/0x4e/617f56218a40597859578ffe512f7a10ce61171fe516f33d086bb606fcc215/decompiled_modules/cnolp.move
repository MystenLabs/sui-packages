module 0x4e617f56218a40597859578ffe512f7a10ce61171fe516f33d086bb606fcc215::cnolp {
    struct CNOLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNOLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNOLP>(arg0, 9, b"CNOLP", b"CETUS EXPLOIT", b"CETUS NO LP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b1f8ffa8fe5b0bf7234d092366bd5141blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNOLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNOLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

