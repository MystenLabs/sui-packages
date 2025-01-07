module 0x504ffe6695c44c0b431819e5d149a859e4b309f9ead51815f212ad138a37a038::tamil {
    struct TAMIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMIL>(arg0, 6, b"TAMIL", b"TAMIL Languge", b"Tamil is a ancient language in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tamil_High_quality_b857f7c2bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

