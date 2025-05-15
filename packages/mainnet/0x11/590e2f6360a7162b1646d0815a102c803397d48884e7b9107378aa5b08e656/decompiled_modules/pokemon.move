module 0x11590e2f6360a7162b1646d0815a102c803397d48884e7b9107378aa5b08e656::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"Pokemon", b"Just A Pokemon Token", x"4a757374204120506f6b656d6f6e20546f6b656e0a0a504f4b454d4f4e2047414d4520494e2054484520465554555245", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemfvdwsl6carhza6zfpqobjkic2owiqid5jc54qfhpmpsw2byr3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

