module 0xd5a4cebe8fa342adc3efb5d17a415a524e10c0c7da96fc6fa6fdd6611e190210::hna {
    struct HNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNA>(arg0, 9, b"HNA", b"HNNA", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb03c84c-63d7-4129-84c3-57b69b17dcea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

