module 0xa2d99e407bee4b7d662b0f5fe7dcbc79019ed24d22f2adfb5d6eb6febd01d5::adison {
    struct ADISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADISON>(arg0, 6, b"ADISON", b"Adison Sui", b"$ADISON stampede across the $SUI battlefield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd74vqrb7etdcuyrxaapu7uvqw3w327scucvgpfti7dmchtn4xpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADISON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

