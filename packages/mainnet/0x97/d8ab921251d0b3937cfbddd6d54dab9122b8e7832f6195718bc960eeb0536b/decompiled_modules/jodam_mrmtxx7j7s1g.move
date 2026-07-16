module 0x97d8ab921251d0b3937cfbddd6d54dab9122b8e7832f6195718bc960eeb0536b::jodam_mrmtxx7j7s1g {
    struct JODAM_MRMTXX7J7S1G has drop {
        dummy_field: bool,
    }

    fun init(arg0: JODAM_MRMTXX7J7S1G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JODAM_MRMTXX7J7S1G>(arg0, 9, b"JODAM", b"JodabreitMeme", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYsSPQF5WEX7qTPp8xvnW5dvAQrBDFKFtAQHg6GWpwNBm")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JODAM_MRMTXX7J7S1G>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JODAM_MRMTXX7J7S1G>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

