module 0xad1521ea29e6b849818927bd02bf23179ac4488ac21530b6db714dab2b742c3d::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 9, b"TOK", b"TOKEN", b"My token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ed7a2d20-0e13-11f0-8d6d-c97d944baca4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOK>>(v1);
        0x2::coin::mint_and_transfer<TOK>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

