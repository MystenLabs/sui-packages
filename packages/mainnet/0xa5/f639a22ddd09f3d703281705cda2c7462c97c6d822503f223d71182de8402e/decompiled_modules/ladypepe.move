module 0xa5f639a22ddd09f3d703281705cda2c7462c97c6d822503f223d71182de8402e::ladypepe {
    struct LADYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYPEPE>(arg0, 6, b"LadyPepe", b"SuiLadyPepe", b"Ladypepe is the next sui base pepe coin .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000111115_71910b105b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

