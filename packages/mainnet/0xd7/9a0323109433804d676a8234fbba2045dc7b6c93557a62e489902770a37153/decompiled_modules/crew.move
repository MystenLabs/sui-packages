module 0xd79a0323109433804d676a8234fbba2045dc7b6c93557a62e489902770a37153::crew {
    struct CREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREW>(arg0, 6, b"CREW", b"CREW COIN", x"20e2809c4a6f696e2074686520437265772e204e6f204361707461696e20e28093206a75737420446567656e732ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750292711650.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

