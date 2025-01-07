module 0xc66bccfbded35796adc72eddc927fb59d9cc2cc704b275714ca349ef47e233d7::joke {
    struct JOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKE>(arg0, 9, b"JOKE", b"A joke ", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e5713a9-e63c-45c9-b06a-874c43136501.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

