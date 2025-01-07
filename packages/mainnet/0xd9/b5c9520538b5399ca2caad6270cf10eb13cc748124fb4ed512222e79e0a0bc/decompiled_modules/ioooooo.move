module 0xd9b5c9520538b5399ca2caad6270cf10eb13cc748124fb4ed512222e79e0a0bc::ioooooo {
    struct IOOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IOOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IOOOOOO>(arg0, 9, b"ioooooo", b"uioooo", b"i", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IOOOOOO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IOOOOOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IOOOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

