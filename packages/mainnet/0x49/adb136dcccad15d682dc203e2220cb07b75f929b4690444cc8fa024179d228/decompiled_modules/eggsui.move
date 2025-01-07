module 0x49adb136dcccad15d682dc203e2220cb07b75f929b4690444cc8fa024179d228::eggsui {
    struct EGGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGSUI>(arg0, 6, b"EGGSUI", b"EGGonSUI", b"$EGG, More than just MeMe !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_104048_3b66d041e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

