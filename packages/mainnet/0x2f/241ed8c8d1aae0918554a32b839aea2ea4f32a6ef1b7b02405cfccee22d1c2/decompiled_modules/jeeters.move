module 0x2f241ed8c8d1aae0918554a32b839aea2ea4f32a6ef1b7b02405cfccee22d1c2::jeeters {
    struct JEETERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEETERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEETERS>(arg0, 6, b"Jeeters", b"Jesters", b"Jeet us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736823300168.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEETERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEETERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

