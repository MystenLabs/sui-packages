module 0x7e45dab35db07ecab24fc861c9b460476c7ff03f7c1c2df6993afe1b1462d438::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"EGG on SUI", x"4a75737420616e2065676720696e20746869732062696720736372616d626c656420405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954350419.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

