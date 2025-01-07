module 0x2eb26bd13c8f5e581d8f07a4ed1491e1d919de30bf92233a2d418c8447bf638d::decr {
    struct DECR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECR>(arg0, 9, b"DECR", b"De cry", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc893567-dea7-4c46-aaf0-576c435c1e9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECR>>(v1);
    }

    // decompiled from Move bytecode v6
}

