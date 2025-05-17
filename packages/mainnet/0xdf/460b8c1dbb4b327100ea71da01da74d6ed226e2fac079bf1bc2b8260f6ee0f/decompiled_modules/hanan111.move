module 0xdf460b8c1dbb4b327100ea71da01da74d6ed226e2fac079bf1bc2b8260f6ee0f::hanan111 {
    struct HANAN111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANAN111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANAN111>(arg0, 6, b"HANAN111", b"HANAN", b"HANANZZZZZZZZZZZZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesue5pjzqwy3pofi5jc4pufwxuavaytjazd7iprt3v4mdcoaxiry")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANAN111>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HANAN111>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

