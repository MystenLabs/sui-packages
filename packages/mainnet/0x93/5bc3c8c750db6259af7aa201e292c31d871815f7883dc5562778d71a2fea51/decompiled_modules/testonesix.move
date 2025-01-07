module 0x935bc3c8c750db6259af7aa201e292c31d871815f7883dc5562778d71a2fea51::testonesix {
    struct TESTONESIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTONESIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTONESIX>(arg0, 9, b"TESTONESIX", b"TEST16", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTONESIX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTONESIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTONESIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

