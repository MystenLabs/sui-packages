module 0x8b43eeeddee32344324ea8f2607837eea27e50b0f6bad7d9946f458edaf5c659::ZUK {
    struct ZUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUK>(arg0, 9, b"ZUK", b"Zuk", b"ZUK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://perpsplexity.app/api/artwork/b03765518bbcc49a77e473e97c6396e517e7498b80232409cfa01003720d6e2c")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUK>>(0x2::coin::mint<ZUK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUK>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

