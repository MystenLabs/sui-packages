module 0x3be36503d659b9a1d2003bbe38f3e8a94280db85c07c6c63c11e851b1cb1886f::happy {
    struct HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY>(arg0, 9, b"HAPPY", b"HAPPYDAY", b"happy day!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04a8713a-7787-4d02-9ca7-e27bb38bb31f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

