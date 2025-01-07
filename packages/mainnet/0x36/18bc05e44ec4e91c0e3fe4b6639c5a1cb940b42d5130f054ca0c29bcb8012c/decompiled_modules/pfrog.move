module 0x3618bc05e44ec4e91c0e3fe4b6639c5a1cb940b42d5130f054ca0c29bcb8012c::pfrog {
    struct PFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFROG>(arg0, 6, b"PFROG", b"PinkFrog", b"swiming for the dollar in the waters of sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/828e04e086b186f5db218be438c25993_673b882f90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

