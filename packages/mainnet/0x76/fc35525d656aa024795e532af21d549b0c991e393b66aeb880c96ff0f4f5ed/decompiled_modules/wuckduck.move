module 0x76fc35525d656aa024795e532af21d549b0c991e393b66aeb880c96ff0f4f5ed::wuckduck {
    struct WUCKDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUCKDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUCKDUCK>(arg0, 6, b"Wuckduck", b"Wuckduck On Sui", b"Wuckduck The Duck Sui Shines Bright", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_wuckduck_2e6273a41e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUCKDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUCKDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

