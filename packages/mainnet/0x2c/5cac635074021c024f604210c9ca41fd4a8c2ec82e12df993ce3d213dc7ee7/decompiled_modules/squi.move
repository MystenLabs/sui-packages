module 0x2c5cac635074021c024f604210c9ca41fd4a8c2ec82e12df993ce3d213dc7ee7::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 6, b"SQUI", b"SQUI ", b"$SQUI is the cutest mollusc to ever grace the depths of the $Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730957660017.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

