module 0x539b1c24458e9ab1f2d0491fc710b4f71e6cb807f949d1b9776e7f1adb38b0a0::eta {
    struct ETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETA>(arg0, 9, b"ETA", b"Jason ETA", b"WHAT'S YOUR ETAA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7df009f2-b63a-4641-a3a5-cb590accb24c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

