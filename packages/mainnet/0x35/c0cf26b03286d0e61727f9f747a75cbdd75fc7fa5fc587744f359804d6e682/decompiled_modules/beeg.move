module 0x35c0cf26b03286d0e61727f9f747a75cbdd75fc7fa5fc587744f359804d6e682::beeg {
    struct BEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEG>(arg0, 6, b"BEEG", b"Beeg Blue Whale", b"https://x.com/BeegBlue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_WX_3_Ni_He_400x400_a0a2667f81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

