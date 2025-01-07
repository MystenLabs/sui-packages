module 0xe12adae387eaa333a9e403de37a2ea59798861313db87f555af2582b72b72dbe::owbsb {
    struct OWBSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWBSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWBSB>(arg0, 9, b"OWBSB", b"hdbs", b"jdjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd5d824e-955e-42f0-9b80-c54159c48aa2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWBSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWBSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

