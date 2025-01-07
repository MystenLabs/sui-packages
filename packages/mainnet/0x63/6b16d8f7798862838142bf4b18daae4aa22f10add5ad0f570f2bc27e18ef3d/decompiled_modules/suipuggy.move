module 0x636b16d8f7798862838142bf4b18daae4aa22f10add5ad0f570f2bc27e18ef3d::suipuggy {
    struct SUIPUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUGGY>(arg0, 6, b"SUIPUGGY", b"SuiPuggy", b"SUI Puggy is barking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeiffhd5pqf5yb4r734sqw7j4cnjow3356m3tzrookkda6vhyrar4fi.ipfs.dweb.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUGGY>>(v1);
        0x2::coin::mint_and_transfer<SUIPUGGY>(&mut v2, 1000000000000, @0x41fb373884668f5fe28f0d377e648d465a1f811fdb1fed5343582b3e73d02789, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUGGY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

