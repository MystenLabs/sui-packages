module 0x9ffb5c02e7c47c28c98f1785f8b57a23eb6af8a6d40efc5936ce0f8b5272e7fa::ostter {
    struct OSTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSTTER>(arg0, 6, b"OSTTER", b"Otter SUI", b"The Playful Mascot of Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpe2fm2b4yidi4nenqevtdtjjomvj3ogipjw56prgywrruimx4ta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSTTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

