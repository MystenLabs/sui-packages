module 0x7f873661b036518a7fca9587a6ca949ad96fdf5111366fe210804464f09bf1b7::voci {
    struct VOCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOCI>(arg0, 6, b"VOCI", b"Voci AI", b"$VOCI - The ultimate Al platform harnessing the boundlessness of knowledge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735353653800.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

