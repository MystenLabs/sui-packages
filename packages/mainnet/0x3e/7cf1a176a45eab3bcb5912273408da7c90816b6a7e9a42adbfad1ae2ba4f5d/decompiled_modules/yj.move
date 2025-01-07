module 0x3e7cf1a176a45eab3bcb5912273408da7c90816b6a7e9a42adbfad1ae2ba4f5d::yj {
    struct YJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJ>(arg0, 9, b"YJ", b"Tyh", b"Ghh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab78a1ca-321f-41d9-bfae-243ca2e470ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

