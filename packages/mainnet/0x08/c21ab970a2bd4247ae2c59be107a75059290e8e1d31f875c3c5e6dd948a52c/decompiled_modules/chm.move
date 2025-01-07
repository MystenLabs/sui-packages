module 0x8c21ab970a2bd4247ae2c59be107a75059290e8e1d31f875c3c5e6dd948a52c::chm {
    struct CHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHM>(arg0, 9, b"CHM", b"Chamomile", b"good smell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac10ee01-e4a3-4984-b1dd-14cd968b4656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

