module 0xc14770904833f0f469cc573999622531903b838368172d7115876aef3394e597::tiki {
    struct TIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKI>(arg0, 6, b"TIKI", b"TIKITIKI", b"$TIKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_J9_qbr_M_400x400_13e5144179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

