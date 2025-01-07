module 0x309b2659091fbc16180eebf95920dcb0f2bb786418595777ebb93146c23b58c3::sym {
    struct SYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYM>(arg0, 9, b"sym", b"1111", b"12313", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://image")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYM>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

