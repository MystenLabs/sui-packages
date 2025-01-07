module 0x2a43cd9a9e6c11891cb0439aa58a68d6d4899a4269227c3ba9d46ec3bf69365d::yj {
    struct YJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJ>(arg0, 9, b"YJ", b"VBC", b"XCZV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9398d3c-d475-4e38-9bed-5bf79f0ce6e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

