module 0xf37694c9ef184040876083cb077d5c9d7a506b62c0e8004371df608d41e96838::zager {
    struct ZAGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAGER>(arg0, 6, b"ZAGER", b"Zager On Sui", b"Just Zager, but all the power you need. Zager brings you the pure essence of sui Chainstripped down, simplified, and ready to moon. Why take the whole coin when a bit is enough to make you rich? Welcome to Zager, where a little goes a long way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061933_18ff3e5623.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

