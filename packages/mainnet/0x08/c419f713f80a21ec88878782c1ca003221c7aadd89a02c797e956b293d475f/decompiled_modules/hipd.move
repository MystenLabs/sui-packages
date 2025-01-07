module 0x8c419f713f80a21ec88878782c1ca003221c7aadd89a02c797e956b293d475f::hipd {
    struct HIPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPD>(arg0, 6, b"HIPD", b"Hippowdon", b"It is surprisingly quick to anger. It holds its mouth agape as a display of its strength.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hipp_0d72c0aef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

