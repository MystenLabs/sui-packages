module 0xe8bcdc02e43369e783c74a5eb6da3ad6d4692173b9d7d9a3cc6492d6105114c2::khamoo {
    struct KHAMOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAMOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAMOO>(arg0, 6, b"Khamoo", b"Sui Khamoo", b"KHAMOO - Moo deng's Cousin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023792_bbcfeecef3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAMOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAMOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

