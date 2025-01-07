module 0x8625b555542c467aace59680368224ea546922b17bbe3d26bd6e6da39d099cb1::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"FLOKI", b"$FLOKI", b"FLOKI+SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8a12d046_eafb_44ce_bbd9_11ede7cbd282_FLOKI_2x_1061d2600d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

