module 0x9bae393125fb9cd4bf13ed39ad1d24fa9fd049f7d9193658186006ca034896ad::cncn {
    struct CNCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNCN>(arg0, 6, b"CNCN", b"CNCNCN", b"CN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728748978185_01cb2a34b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CNCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

