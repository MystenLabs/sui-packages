module 0xad27e4eefc9dd37e193a0e4c2ce3ddc1c6c89ffe932e73aeaf4aa02140723200::dird {
    struct DIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIRD>(arg0, 9, b"DIRD", b"Dirdu Sweu", b"Probably something ))", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f94ae3a8-4798-4a5f-a72e-7c9927f1daac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

