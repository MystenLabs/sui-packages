module 0x37facb1cc730205706619233dd3266abf2362b9f6d1f8011a2a9b36d3578e67::wmm {
    struct WMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMM>(arg0, 9, b"WMM", b"LMWMM", b"lmwmm blog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0868448a-7daf-4edc-a66a-1b32b85c34a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

