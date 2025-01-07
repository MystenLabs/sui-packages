module 0xdd89beb00375745061f1d491c2a55b23400413fd686d2367ce7607a18711fcf1::furby {
    struct FURBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURBY>(arg0, 6, b"FURBY", b"Furbys are coming", b"The more you play with me, the more I do! I will keep amazing you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731528358810.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FURBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

