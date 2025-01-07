module 0x91be399a233cf2281dc8e637599e66c6b8e4fb5bcea88d8bf356d25dae1af67f::btcat {
    struct BTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCAT>(arg0, 9, b"BTCAT", b"BITCOIN TRADER CAT", b"$BTCAT - THE BITCOIN TRADER CAT , WHO LIKES TO SMOKE WEED AND DRINK BEER, IT CAN BE SEEN BY HIS FAT ASS, STUPID NOOB FACE, PUPPET FARM CAT BUS IS HERE TO ROCK !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

