module 0x3c98f229ae66a3dec0afcc1647e3c1acd04f5fd24ed3c03f9b5b8cdc42243890::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"Funny", b"Funny meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

