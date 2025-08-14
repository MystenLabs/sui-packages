module 0xe9305be36a78342757641931cb1d3c8411c2d25c7239339a6c4c7e363f363001::adison {
    struct ADISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADISON>(arg0, 6, b"ADISON", b"AdisonSui", b"From Suipringfield to the SUI frontlines", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd74vqrb7etdcuyrxaapu7uvqw3w327scucvgpfti7dmchtn4xpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADISON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

