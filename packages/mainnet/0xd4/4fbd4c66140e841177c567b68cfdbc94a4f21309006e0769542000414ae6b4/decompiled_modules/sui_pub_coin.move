module 0xd44fbd4c66140e841177c567b68cfdbc94a4f21309006e0769542000414ae6b4::sui_pub_coin {
    struct SUIPUB has drop {
        dummy_field: bool,
    }

    public fun initialize(arg0: SUIPUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUB>(arg0, 6, b"SPUB", b"SuiPub", b"SUI Pub is barking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeiffhd5pqf5yb4r734sqw7j4cnjow3356m3tzrookkda6vhyrar4fi.ipfs.dweb.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUB>>(v1);
        0x2::coin::mint_and_transfer<SUIPUB>(&mut v2, 1000000000000, @0x41fb373884668f5fe28f0d377e648d465a1f811fdb1fed5343582b3e73d02789, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

