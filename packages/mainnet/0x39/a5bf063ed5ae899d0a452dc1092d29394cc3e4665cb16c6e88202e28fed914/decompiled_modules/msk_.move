module 0x39a5bf063ed5ae899d0a452dc1092d29394cc3e4665cb16c6e88202e28fed914::msk_ {
    struct MSK_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSK_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSK_>(arg0, 9, b"MSK_", b"Musk", b"Musk is created in appreciation of Legendary Elon Musk giant technological strides", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1f5da76-4b81-404b-a162-45b98a17a2e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSK_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSK_>>(v1);
    }

    // decompiled from Move bytecode v6
}

