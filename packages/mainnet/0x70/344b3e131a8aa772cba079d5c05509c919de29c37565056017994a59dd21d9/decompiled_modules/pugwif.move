module 0x70344b3e131a8aa772cba079d5c05509c919de29c37565056017994a59dd21d9::pugwif {
    struct PUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIF>(arg0, 6, b"PUGWIF", b"Pugwif hat sui", b"Resurging from the ashes of a premature rug, arose the pug that doesn't quit. His message is clear: he won't stand for scams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_150855_362_5a9417b1da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

