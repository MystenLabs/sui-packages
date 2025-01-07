module 0x533482727a82a35fba55416c5fd82d88d9da0242f65c1bc53ecd5f1d6a6fa399::suifty {
    struct SUIFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFTY>(arg0, 9, b"SUIFTY", b"Taylor Suifty", x"42656361757365206576656e20796f75722063727970746f2064657365727665732061204772616d6d792d776f7274687920676c6f772d757021e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

