module 0x205d97fa89010a997c97578c312eae6fe1482e0cdbaf8ca1b3462207f802d708::adison {
    struct ADISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADISON>(arg0, 6, b"ADISON", b"Adison OG", b"The quiet mastermind of the meme world. Hidden behind thick frames and a knowing smirk, ADISON doesn`t say much. Say HELLO to ADISON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd74vqrb7etdcuyrxaapu7uvqw3w327scucvgpfti7dmchtn4xpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADISON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

