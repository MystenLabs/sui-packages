module 0xf179ae7cd4101a482453d9a239928fc98923c74e321f83d7202f8a7033e495e7::ricki {
    struct RICKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKI>(arg0, 6, b"RICKI", b"RICKY THE PRNGUIN", b"HEY IT'S RICKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rikki_6386cd3d68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

