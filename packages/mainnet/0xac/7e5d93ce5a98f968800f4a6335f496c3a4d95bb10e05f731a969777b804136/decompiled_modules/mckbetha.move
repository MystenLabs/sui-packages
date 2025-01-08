module 0xac7e5d93ce5a98f968800f4a6335f496c3a4d95bb10e05f731a969777b804136::mckbetha {
    struct MCKBETHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCKBETHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCKBETHA>(arg0, 9, b"MCKBETHA", b"MKBETHT", b"MOCKBETHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCKBETHA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCKBETHA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCKBETHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

