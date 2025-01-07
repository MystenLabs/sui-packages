module 0x177af80027949f14ea2d404c1a50f8f7f94d609a4976226589eae81b46952a17::awok {
    struct AWOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWOK>(arg0, 5, b"AWOK", b"Awokwok", b"Awokwok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/nV1sY59P/wwwwwww.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AWOK>(&mut v2, 6900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

