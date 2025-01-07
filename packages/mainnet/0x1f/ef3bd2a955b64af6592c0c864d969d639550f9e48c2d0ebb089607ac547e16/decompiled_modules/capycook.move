module 0x1fef3bd2a955b64af6592c0c864d969d639550f9e48c2d0ebb089607ac547e16::capycook {
    struct CAPYCOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYCOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYCOOK>(arg0, 9, b"CAPYCOOK", b"CAPY COOK", b"HOLD UP! LET CAPYBARA COOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0cc9a2e3-345e-4dca-af35-eb07e6b96592.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYCOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYCOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

