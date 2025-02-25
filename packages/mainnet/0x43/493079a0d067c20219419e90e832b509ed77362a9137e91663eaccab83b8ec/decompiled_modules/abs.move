module 0x43493079a0d067c20219419e90e832b509ed77362a9137e91663eaccab83b8ec::abs {
    struct ABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABS>(arg0, 9, b"ABS", b"Abstract", b"Abstract native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/785f3722-f1b1-4c92-b616-f32a0db5d993.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

