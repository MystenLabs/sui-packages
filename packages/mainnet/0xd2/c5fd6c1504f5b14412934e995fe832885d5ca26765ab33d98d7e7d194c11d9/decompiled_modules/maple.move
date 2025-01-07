module 0xd2c5fd6c1504f5b14412934e995fe832885d5ca26765ab33d98d7e7d194c11d9::maple {
    struct MAPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPLE>(arg0, 6, b"MAPLE", b"ABOOT", b"Aboot is more than just a token; it's a maple syrup-drizzled celebration of Canadian culture. With its sticky-sweet tokenomics and warm, fuzzy community, Aboot is sure to maple your day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aboot_20fe8ee882.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

