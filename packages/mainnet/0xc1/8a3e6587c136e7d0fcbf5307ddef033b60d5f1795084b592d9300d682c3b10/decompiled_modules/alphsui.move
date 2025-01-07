module 0xc18a3e6587c136e7d0fcbf5307ddef033b60d5f1795084b592d9300d682c3b10::alphsui {
    struct ALPHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHSUI>(arg0, 6, b"Alphsui", b"AlphaSui", b"Alpha in crypto is like that one friend who somehow makes money even when everyone else is just praying not to get \"rekt!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LP_c42849ac70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

