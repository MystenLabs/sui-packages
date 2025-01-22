module 0x494e44126fe4b792fb93aed761e18433f247e73864879288aa03eb2bef3c24ed::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOK>(arg0, 4, b"TOK", b"Token", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/06095b00-d8a3-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOK>>(v1);
        0x2::coin::mint_and_transfer<TOK>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

