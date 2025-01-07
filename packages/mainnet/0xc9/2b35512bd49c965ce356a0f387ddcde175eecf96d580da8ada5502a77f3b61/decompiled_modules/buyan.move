module 0xc92b35512bd49c965ce356a0f387ddcde175eecf96d580da8ada5502a77f3b61::buyan {
    struct BUYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUYAN>(arg0, 9, b"BUYAN", b"BB", b"Buyan Boutiq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/962901ca-c1d2-42d8-b18b-6afc3b026243.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

