module 0xac9665fee7f8826533b5a0ee8d014cb08ec3a65bd6b6b7aca4270de1c7d24e17::kfrc {
    struct KFRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFRC>(arg0, 6, b"KFRC", b"Kfroc", b"kfrc - blue frog on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiawqowrnpuxyre474c2us5ewazp75uwq5zuwjjncmyrrhtv7qbemm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KFRC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

