module 0xdf0b8adc525981202bd17ddadaf46ffbdf40a46909a07bd6474ed8fb479e3601::bon {
    struct BON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BON>(arg0, 9, b"BON", b"Ersh", b"Auuaah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d2a31ca-813a-46ca-a876-74e7bfc18313.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BON>>(v1);
    }

    // decompiled from Move bytecode v6
}

