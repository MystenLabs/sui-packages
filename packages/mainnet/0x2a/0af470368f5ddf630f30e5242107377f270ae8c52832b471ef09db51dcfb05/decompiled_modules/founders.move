module 0x2a0af470368f5ddf630f30e5242107377f270ae8c52832b471ef09db51dcfb05::founders {
    struct FOUNDERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUNDERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUNDERS>(arg0, 6, b"FOUNDERS", b"Sui Founders", b"As pictured in @gdanezis head, the founders of the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743010580758.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOUNDERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOUNDERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

