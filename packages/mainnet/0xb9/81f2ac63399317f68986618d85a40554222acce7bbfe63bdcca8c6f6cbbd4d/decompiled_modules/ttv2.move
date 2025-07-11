module 0xb981f2ac63399317f68986618d85a40554222acce7bbfe63bdcca8c6f6cbbd4d::ttv2 {
    struct TTV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTV2>(arg0, 9, b"TTv2", b"Test token with 9 decimals", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTV2>>(v1);
        0x2::coin::mint_and_transfer<TTV2>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTV2>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

