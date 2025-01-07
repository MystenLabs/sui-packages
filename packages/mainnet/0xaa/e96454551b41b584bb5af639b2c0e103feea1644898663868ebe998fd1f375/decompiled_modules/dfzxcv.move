module 0xaae96454551b41b584bb5af639b2c0e103feea1644898663868ebe998fd1f375::dfzxcv {
    struct DFZXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFZXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFZXCV>(arg0, 9, b"DFZXCV", b"KJHAF", b"BBCCZ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45f0bdfd-3c7a-49c8-b21c-fb45884ad5fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFZXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFZXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

