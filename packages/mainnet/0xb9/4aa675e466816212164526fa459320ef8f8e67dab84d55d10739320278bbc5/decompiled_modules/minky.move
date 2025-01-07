module 0xb94aa675e466816212164526fa459320ef8f8e67dab84d55d10739320278bbc5::minky {
    struct MINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINKY>(arg0, 6, b"MINKY", b"Minky on sui", b"Future #memecoin KING $MINKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049047_1975cc2b1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

