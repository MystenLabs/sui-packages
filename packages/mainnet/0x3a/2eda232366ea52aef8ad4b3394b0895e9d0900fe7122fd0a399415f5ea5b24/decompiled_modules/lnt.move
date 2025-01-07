module 0x3a2eda232366ea52aef8ad4b3394b0895e9d0900fe7122fd0a399415f5ea5b24::lnt {
    struct LNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNT>(arg0, 9, b"LNT", b"Lent", b"Utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e02e13d2-933e-42c4-bacf-17e40dcdab1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

