module 0x5df19741c48c1cd52231120ef992f5bc899afc0b078460a68b58ddee5f668c06::wagey {
    struct WAGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGEY>(arg0, 6, b"WAGEY", b"WAGEY ON SUI", b"Real product, mini game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wageymaincoinlogo_3_9f04a7941c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

