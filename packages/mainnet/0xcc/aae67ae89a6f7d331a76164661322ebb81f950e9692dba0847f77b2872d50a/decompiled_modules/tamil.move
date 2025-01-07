module 0xccaae67ae89a6f7d331a76164661322ebb81f950e9692dba0847f77b2872d50a::tamil {
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

