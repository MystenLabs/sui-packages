module 0xf5c72b723c3e73c91009dc651211197634449088b4c05427f32169790cb5d7cf::cc23 {
    struct CC23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC23>(arg0, 6, b"cc23", b"cc23", b"12", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC23>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CC23>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC23>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

