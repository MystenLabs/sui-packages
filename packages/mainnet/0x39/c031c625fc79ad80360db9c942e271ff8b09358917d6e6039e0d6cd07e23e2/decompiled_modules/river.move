module 0x39c031c625fc79ad80360db9c942e271ff8b09358917d6e6039e0d6cd07e23e2::river {
    struct RIVER has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        6
    }

    fun init(arg0: RIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<RIVER>(arg0, decimals(), b"RIVER", b"River", b"https://river.inc/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihpfsr7owkymkrw5onbc3v6ryvoq5dvfdhhktdt4cjgvoxrunfax4")), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<RIVER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIVER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

