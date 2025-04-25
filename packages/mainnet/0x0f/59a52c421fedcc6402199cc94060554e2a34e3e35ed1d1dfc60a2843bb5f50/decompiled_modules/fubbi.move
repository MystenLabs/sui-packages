module 0xf59a52c421fedcc6402199cc94060554e2a34e3e35ed1d1dfc60a2843bb5f50::fubbi {
    struct FUBBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBBI>(arg0, 6, b"FUBBI", b"Fubbi", b"Fubbi Fubbi Fubbi Fubbi Fubbi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013576_18a2d4fb2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUBBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

