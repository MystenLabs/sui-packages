module 0x4edba9966e424e15d47f2dc282743730328d028bb80435959bb0a67c9ee2b8a::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SuiPepe", b"Suipepe", b"Pepe comes to sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/654242_8bd0744a2b6a4ef3848ad4bf0896c3a7_mv2_a_ae_a_ae_3b990f5106.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

