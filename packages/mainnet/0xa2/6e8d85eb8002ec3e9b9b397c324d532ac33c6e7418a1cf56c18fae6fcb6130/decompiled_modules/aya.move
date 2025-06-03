module 0xa26e8d85eb8002ec3e9b9b397c324d532ac33c6e7418a1cf56c18fae6fcb6130::aya {
    struct AYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYA>(arg0, 6, b"AYA", b"Aya on Sui", b"Crying Aya Asagiri Meme Generator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaisyg4dqi5rzv44v5ci7qwp7bpvye3c4recb52y5nl5sr4ulsvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AYA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

