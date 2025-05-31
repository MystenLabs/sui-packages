module 0x2fc5b3355881e924ee1e79de1b5a586e3b42ab7f9d54982405f9c122dffae30e::nailong {
    struct NAILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAILONG>(arg0, 6, b"NaiLong", b"Nailong", b"Nailong apply to join your life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748707121175.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAILONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAILONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

