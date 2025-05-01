module 0xc553f02e8208dbca55272ff19d3a30336c265745e309abe4037d1d2236bd4b11::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"Gh", b"mmmmmmmmmmmmm", b"ttttttttttttttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4c6329cc3745b5d0af448c6c4f1c5951blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

