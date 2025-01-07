module 0xd800dd39dc291cd15d421666bc40363349b1f7f047065084c6ea651ffda68c55::jamtb_199x {
    struct JAMTB_199X has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMTB_199X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMTB_199X>(arg0, 9, b"JAMTB_199X", b"Jamtb", x"f09fa6b4f09fa6b4f09fa6b4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8182459c-18f7-4dc5-a64e-aaf874ccb096.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMTB_199X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMTB_199X>>(v1);
    }

    // decompiled from Move bytecode v6
}

