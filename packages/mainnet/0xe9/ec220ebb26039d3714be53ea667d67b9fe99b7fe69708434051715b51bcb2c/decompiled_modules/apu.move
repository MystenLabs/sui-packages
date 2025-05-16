module 0xe9ec220ebb26039d3714be53ea667d67b9fe99b7fe69708434051715b51bcb2c::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 6, b"APU", b"Apu Apustaja", b"Elon replied to the APU crypto ticker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrmrrtnju7tqmi7krtjzv46qflqqxs2zjagsyjvkdoeihnqkk6p4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

