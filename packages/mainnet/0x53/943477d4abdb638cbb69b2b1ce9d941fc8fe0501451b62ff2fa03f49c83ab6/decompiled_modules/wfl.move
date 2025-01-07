module 0x53943477d4abdb638cbb69b2b1ce9d941fc8fe0501451b62ff2fa03f49c83ab6::wfl {
    struct WFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFL>(arg0, 9, b"WFL", b"wheat fiel", b"NICE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f75d854-6370-4ed2-b2de-2f76c0170a93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

