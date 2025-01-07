module 0xc7d5c5209c2f8348e0834715c97efeb7990c42a5a737960a56068ec615284a3c::ooppp {
    struct OOPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOPPP>(arg0, 6, b"OOPPP", b"Onky Onky Plock Plock Plock", x"4f6e6b79204f6e6b7920506c6f636b20506c6f636b20506c6f636b0a43616361204361636120446f6f646c6520426f636b20426f636b20426f636b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030466_c7e68c3001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOPPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOPPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

