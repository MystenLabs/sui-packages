module 0xd8d81569d9a7e2cf248e602d4460b08a6102a3e3995fd943ba4a578cefae946a::podai {
    struct PODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PODAI>(arg0, 6, b"PODAI", b"Poke Daily", b"Your front row, handheld look at real world Pokemon trainers, epic catches, and battles live across Kanto on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigior67rp3kmzmatsahlm4julw5o3mrbwp6eo6y2bh27tq37bn7xu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PODAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PODAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

