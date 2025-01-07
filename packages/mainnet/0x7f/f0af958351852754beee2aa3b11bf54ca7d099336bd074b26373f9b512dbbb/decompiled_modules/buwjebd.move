module 0x7ff0af958351852754beee2aa3b11bf54ca7d099336bd074b26373f9b512dbbb::buwjebd {
    struct BUWJEBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUWJEBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUWJEBD>(arg0, 9, b"BUWJEBD", b"hsjsna", b"bdjajwn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28aa56fc-2536-4b77-bc19-d0281deb3e48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUWJEBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUWJEBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

