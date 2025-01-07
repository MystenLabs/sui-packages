module 0x9a2cffa8f609bcc995143ff7568e8d89574ead8ed2b01b622e8d93039b10aa25::KV_STAGING_VSUI {
    struct KV_STAGING_VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_STAGING_VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_STAGING_VSUI>(arg0, 6, b"KV_STAGING_VSUI", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_STAGING_VSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_STAGING_VSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

