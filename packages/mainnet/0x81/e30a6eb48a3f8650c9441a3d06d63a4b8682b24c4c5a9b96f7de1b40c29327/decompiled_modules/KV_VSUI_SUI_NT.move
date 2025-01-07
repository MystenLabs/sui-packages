module 0x81e30a6eb48a3f8650c9441a3d06d63a4b8682b24c4c5a9b96f7de1b40c29327::KV_VSUI_SUI_NT {
    struct KV_VSUI_SUI_NT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_VSUI_SUI_NT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_VSUI_SUI_NT>(arg0, 6, b"KV_VSUI_SUI_NT", b"KV_VSUI_SUI_NT", b"staging kriya V3 clmm token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_VSUI_SUI_NT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_VSUI_SUI_NT>>(v1);
    }

    // decompiled from Move bytecode v6
}

