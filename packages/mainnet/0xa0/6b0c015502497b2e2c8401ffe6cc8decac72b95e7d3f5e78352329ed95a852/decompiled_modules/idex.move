module 0xa06b0c015502497b2e2c8401ffe6cc8decac72b95e7d3f5e78352329ed95a852::idex {
    struct IDEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDEX>(arg0, 9, b"IDEX", b"INSTA", b"Arena Instadex smoke", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IDEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

