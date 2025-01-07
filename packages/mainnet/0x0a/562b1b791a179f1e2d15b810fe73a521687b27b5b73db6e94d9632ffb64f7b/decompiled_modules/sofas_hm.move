module 0xa562b1b791a179f1e2d15b810fe73a521687b27b5b73db6e94d9632ffb64f7b::sofas_hm {
    struct SOFAS_HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAS_HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAS_HM>(arg0, 9, b"SOFAS_HM", b"SZOFA", b"Great news SOFA is coming in market and it is boooooom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efabe530-2077-473b-896e-95640d6d956d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAS_HM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFAS_HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

