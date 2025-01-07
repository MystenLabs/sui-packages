module 0x9f2091c5c319bd336d8f80c16e183f94aa3f6e74f0355026b793439657a494ad::ylw {
    struct YLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YLW>(arg0, 9, b"YLW", b"yellow", b"memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbf56ffe-ad2f-4771-bd06-a1d861d6f67b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

