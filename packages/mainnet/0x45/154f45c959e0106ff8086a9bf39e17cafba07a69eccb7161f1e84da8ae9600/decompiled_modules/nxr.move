module 0x45154f45c959e0106ff8086a9bf39e17cafba07a69eccb7161f1e84da8ae9600::nxr {
    struct NXR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXR>(arg0, 9, b"NXR", b"Nexarion", x"436f6e6e656374697669747920616e642050726f67726573730a4465736372697074696f6e3a204e65786172696f6e20726570726573656e74732074686520636f6e6e656374696f6e206265747765656e20747261646974696f6e616c2066696e616e636520616e64206469676974616c2063757272656e636965732c2073796d626f6c697a696e672070726f677265737320616e6420696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd3de239-8b91-4539-9ce6-7cd6b6dd4d7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NXR>>(v1);
    }

    // decompiled from Move bytecode v6
}

