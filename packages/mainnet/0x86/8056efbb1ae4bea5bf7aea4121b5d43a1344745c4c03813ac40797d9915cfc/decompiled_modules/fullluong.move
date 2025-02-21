module 0x868056efbb1ae4bea5bf7aea4121b5d43a1344745c4c03813ac40797d9915cfc::fullluong {
    struct FULLLUONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FULLLUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FULLLUONG>(arg0, 12, b"fullluong", b"fullluong", b"fullluong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"fullluong")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FULLLUONG>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FULLLUONG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FULLLUONG>>(v2);
    }

    // decompiled from Move bytecode v6
}

