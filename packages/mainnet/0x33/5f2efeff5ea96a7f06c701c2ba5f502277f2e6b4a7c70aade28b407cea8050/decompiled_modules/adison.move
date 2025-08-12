module 0x335f2efeff5ea96a7f06c701c2ba5f502277f2e6b4a7c70aade28b407cea8050::adison {
    struct ADISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADISON>(arg0, 6, b"ADISON", b"AdisonSui", b"Adison sees it all. Through the shades lies a sharp mind, scanning the chaos and spotting the gold. A thinker, a schemer, a silent sniper in the world of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifd74vqrb7etdcuyrxaapu7uvqw3w327scucvgpfti7dmchtn4xpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADISON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

