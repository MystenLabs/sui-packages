module 0xcf12e471fb9f12d0743bb6ce5da18f19e6a915b6823390b9cda86dc23fdd05da::suibza {
    struct SUIBZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBZA>(arg0, 6, b"SUIBZA", b"SUIbizaa", b"Ooooh where going to SUibizaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0970_6e050eb2f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

