module 0x56b53d4fb6506218b39d7e2eff3d8a2285bcaaabf7caff8a203af282ee543f37::hmr {
    struct HMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMR>(arg0, 9, b"HMR", b"humor", x"73656e7365206f662068756d6f7220636f696e206973206e6f772068657265f09fa4aa20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07a4bd21-f93f-439b-849e-8d23de1cf09f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

