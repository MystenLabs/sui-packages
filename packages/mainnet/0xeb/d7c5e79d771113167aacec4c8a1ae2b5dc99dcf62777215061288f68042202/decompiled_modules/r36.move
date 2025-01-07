module 0xebd7c5e79d771113167aacec4c8a1ae2b5dc99dcf62777215061288f68042202::r36 {
    struct R36 has drop {
        dummy_field: bool,
    }

    fun init(arg0: R36, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R36>(arg0, 9, b"R36", b"R24", b"Online help 24", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f476051a-cc2f-4733-9f4f-bf4303b287b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R36>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R36>>(v1);
    }

    // decompiled from Move bytecode v6
}

