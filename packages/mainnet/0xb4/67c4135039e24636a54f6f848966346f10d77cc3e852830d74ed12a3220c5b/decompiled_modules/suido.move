module 0xb467c4135039e24636a54f6f848966346f10d77cc3e852830d74ed12a3220c5b::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"Suidowoodo", b"To avoid being attacked, it does nothing but mimic a tree. It loves water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexlkmmk33e4phivxheaqfkpxwqrd7ixbzl6ee5rhwgqwru2uopwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

