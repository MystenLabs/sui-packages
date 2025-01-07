module 0xa99f8efdc741fee48bda1399f1419681222730b3b016de964e29de7cacf4446a::poorguy {
    struct POORGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POORGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORGUY>(arg0, 6, b"PoorGuy", b"Poor Guy On SUI", b"We are Same", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_poor_man_with_empty_pockets_vector_cartoon_illustration_64_89a5e6c062.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POORGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

