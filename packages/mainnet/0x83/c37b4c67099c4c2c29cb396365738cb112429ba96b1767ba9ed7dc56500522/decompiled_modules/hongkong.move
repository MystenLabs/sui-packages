module 0x83c37b4c67099c4c2c29cb396365738cb112429ba96b1767ba9ed7dc56500522::hongkong {
    struct HONGKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONGKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONGKONG>(arg0, 6, b"HONGKONG", b"Hong Kong SUI", b"Hong Kong SUI the best cartoon of the 90s is back to reign on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hong_Kong_Phooey_a5e0ba2e12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONGKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONGKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

