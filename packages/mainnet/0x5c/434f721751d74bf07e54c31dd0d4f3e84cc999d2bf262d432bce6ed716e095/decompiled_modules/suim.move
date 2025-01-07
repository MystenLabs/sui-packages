module 0x5c434f721751d74bf07e54c31dd0d4f3e84cc999d2bf262d432bce6ed716e095::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUI ROOM", b"Leverages the power of artificial intelligence with SUI ROOM by AI Room Foundation. $SUIM to ensure top-notch security for every transaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_19_596ec623f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

