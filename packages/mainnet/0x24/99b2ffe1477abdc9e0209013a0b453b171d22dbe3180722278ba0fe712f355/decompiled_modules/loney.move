module 0x2499b2ffe1477abdc9e0209013a0b453b171d22dbe3180722278ba0fe712f355::loney {
    struct LONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONEY>(arg0, 6, b"LONEY", b"Loney sui", b"Not a bird, not a man, not an animal, Loney is a memento of the creation of the lord jesus that will be so great", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcuwjespk2xou4fwcwshbwu7zoao27m5cbpx2vgturmjvum2q77y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LONEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

