module 0xf02974a2ed38b96534fc03fd51d9a9d7d4390bef14e0f6bc2b04c7deecf456dc::scramble {
    struct SCRAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAMBLE>(arg0, 6, b"sCrAmBlE", b"sCrAmBlE mE", b"The first 3 words you see are what your angels have in store for you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ggq_Jo_R_Dag_A_Azjmj_4a7f90fb57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAMBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAMBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

