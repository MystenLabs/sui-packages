module 0x4f9895c741d2bc177610a417bd0ea58c6c53bee6e338aba3626b751fcc4d9539::sameme {
    struct SAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMEME>(arg0, 6, b"Sameme", b"TEST", b"ksksl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxu526f7pso3ydyr2wmiavhhcwcugsbb6asa6gd3yo2n3nkd2gxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

