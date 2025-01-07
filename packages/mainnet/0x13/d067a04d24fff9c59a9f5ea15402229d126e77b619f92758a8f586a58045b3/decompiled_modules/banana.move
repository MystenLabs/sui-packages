module 0x13d067a04d24fff9c59a9f5ea15402229d126e77b619f92758a8f586a58045b3::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"BA NA NA", b"BAN ANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adb93e50-f282-4239-b418-221410ff6b2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

