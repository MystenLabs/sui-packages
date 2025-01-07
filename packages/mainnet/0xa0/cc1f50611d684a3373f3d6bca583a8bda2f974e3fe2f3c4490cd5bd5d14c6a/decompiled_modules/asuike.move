module 0xa0cc1f50611d684a3373f3d6bca583a8bda2f974e3fe2f3c4490cd5bd5d14c6a::asuike {
    struct ASUIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIKE>(arg0, 6, b"ASUIKE", b"Asuike CTO", b"Dev dead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tmo7j_PHT_400x400_02383fa77a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

