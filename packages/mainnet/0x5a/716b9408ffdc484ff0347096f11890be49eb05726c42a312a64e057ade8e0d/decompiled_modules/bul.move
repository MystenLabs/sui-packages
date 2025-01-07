module 0x5a716b9408ffdc484ff0347096f11890be49eb05726c42a312a64e057ade8e0d::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 9, b"BUL", b"BULL RUN", b"Bull run rocket launcherrocket launcher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/359cfef1-78b0-411a-9940-22531986e3d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

