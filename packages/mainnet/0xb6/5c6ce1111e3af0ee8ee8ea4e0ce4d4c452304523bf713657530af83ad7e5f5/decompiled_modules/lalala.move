module 0xb65c6ce1111e3af0ee8ee8ea4e0ce4d4c452304523bf713657530af83ad7e5f5::lalala {
    struct LALALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LALALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LALALA>(arg0, 1, b"lalala", b"xmh", b"hhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/923c5ba0-d98d-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALALA>>(v1);
        0x2::coin::mint_and_transfer<LALALA>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALALA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

