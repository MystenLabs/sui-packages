module 0xadd2dfd6ca02abbc6777815b1ca5e947d43a29f9c4317bab7f3fcf1dcc5e5ff8::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKE>(arg0, 6, b"DUKE", b"DUKES", b"DUKE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731601057555.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

