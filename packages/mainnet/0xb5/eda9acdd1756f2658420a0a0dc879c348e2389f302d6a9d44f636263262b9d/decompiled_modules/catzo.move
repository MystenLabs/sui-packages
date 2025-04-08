module 0xb5eda9acdd1756f2658420a0a0dc879c348e2389f302d6a9d44f636263262b9d::catzo {
    struct CATZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZO>(arg0, 6, b"CATZO", b"Catzo", b"CATZO IS A NEWCUTE CAT MEMECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055322_1fe447f013.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

