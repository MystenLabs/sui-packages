module 0xed83344d1b59107dd71828eb8478a18734810345b0eda4838d9b0d4992b1fa6d::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 9, b"JESUIS", b"Jesuis Christ", b"Rebirth on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fjesuis_pfp_7f8a11247e.jpeg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JESUIS>(&mut v2, 300000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

