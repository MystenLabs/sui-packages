module 0x368ac3a66aa4b34f055a9b2bb3dbc63aef3e7ec9dd2e87a4353998d417fcb908::dnuttz {
    struct DNUTTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUTTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DNUTTZ>(arg0, 6, b"DNUTTZ", b"Diamond Nuttz", b"Powerful steady never sale. Have diamond nuttz my friend ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0328_a4ab3d8ef0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DNUTTZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNUTTZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

