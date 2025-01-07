module 0x71b10e7206db1cccbdcf25aba21b081de95eb25b6279ddddd6c3217e356641bc::flop {
    struct FLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOP>(arg0, 9, b"FLOP", b"FLOPONHEAD", b"Keep $flop ing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1859666480092356608/rZPXBJC8_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

