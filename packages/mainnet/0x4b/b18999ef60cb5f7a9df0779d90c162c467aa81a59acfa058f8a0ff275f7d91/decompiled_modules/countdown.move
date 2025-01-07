module 0x4bb18999ef60cb5f7a9df0779d90c162c467aa81a59acfa058f8a0ff275f7d91::countdown {
    struct COUNTDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUNTDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUNTDOWN>(arg0, 6, b"Countdown", b"CountDuck", x"596f75e28099726520636f756e74696e672074686520646179732c206172656ee280997420796f753f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731452411721.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COUNTDOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUNTDOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

