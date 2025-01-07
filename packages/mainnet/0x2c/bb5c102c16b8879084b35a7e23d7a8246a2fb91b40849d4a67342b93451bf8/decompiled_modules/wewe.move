module 0x2cbb5c102c16b8879084b35a7e23d7a8246a2fb91b40849d4a67342b93451bf8::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 6, b"WEWE", b"WenWen", b"When ? When? Don't Ask Me When", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

