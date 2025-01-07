module 0xbc0bc09b7f210f7f55917919695115379f67b8c7e0d156fa50369082d425cf6e::ais {
    struct AIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIS>(arg0, 9, b"AIS", b"Aishy", b"Aistoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e523b11b-589a-4835-bb6b-96aa00e15d06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

