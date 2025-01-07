module 0xb9afd45b1e2a459a960807009982b02d67da9139b81098290e89b1e237c81a2b::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOG>(arg0, 8, b"PopDog", b"PopDog", b"$POPDOG *POP* *POP* *POP*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPDOG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

