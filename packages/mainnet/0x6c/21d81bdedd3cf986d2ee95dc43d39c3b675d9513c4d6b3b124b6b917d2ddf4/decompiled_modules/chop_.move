module 0x6c21d81bdedd3cf986d2ee95dc43d39c3b675d9513c4d6b3b124b6b917d2ddf4::chop_ {
    struct CHOP_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP_>(arg0, 9, b"Chop", b"Chop sui", b"Chop sui test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHOP_>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP_>>(v1);
    }

    // decompiled from Move bytecode v6
}

