module 0x2f7572ac433053ffe232e1e58428defa4a789709b2c01672fcf46180d92198bb::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DONTBUY>, arg1: 0x2::coin::Coin<DONTBUY>) {
        0x2::coin::burn<DONTBUY>(arg0, arg1);
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 2, b"DONT", b"DONTBUY", b"Please dont buy this token, the chance of rug is high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/image-vector/forbidden-sign-stop-hand-glyph-600nw-758065825.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DONTBUY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DONTBUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

