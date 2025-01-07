module 0x22b7367476c70304e7beefc291f30aa84d250d8555dfefdb22b41c11ff52a215::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 8, b"YUMI", b"Yumi", b"Meet Yumi, the cutest dog of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUMI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

