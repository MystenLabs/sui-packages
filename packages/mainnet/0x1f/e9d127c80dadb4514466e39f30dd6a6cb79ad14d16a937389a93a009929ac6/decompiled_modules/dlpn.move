module 0x1fe9d127c80dadb4514466e39f30dd6a6cb79ad14d16a937389a93a009929ac6::dlpn {
    struct DLPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLPN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLPN>(arg0, 9, b"DLPN", b"DOLPIN", b"Gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe14ac5d-a446-4caa-9c65-1e13dde0cf5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLPN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLPN>>(v1);
    }

    // decompiled from Move bytecode v6
}

