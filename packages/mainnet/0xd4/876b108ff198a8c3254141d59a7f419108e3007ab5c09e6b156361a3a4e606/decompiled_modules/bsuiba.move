module 0xd4876b108ff198a8c3254141d59a7f419108e3007ab5c09e6b156361a3a4e606::bsuiba {
    struct BSUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIBA>(arg0, 2, b"BSUIBA", b"Baby Suiba Inu", b"Baby Suiba Inu is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BSUIBA>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

