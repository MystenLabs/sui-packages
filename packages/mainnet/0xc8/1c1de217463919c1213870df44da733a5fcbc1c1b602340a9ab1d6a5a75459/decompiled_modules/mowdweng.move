module 0xc81c1de217463919c1213870df44da733a5fcbc1c1b602340a9ab1d6a5a75459::mowdweng {
    struct MOWDWENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOWDWENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOWDWENG>(arg0, 9, b"MOWDWENG", b"Sui Mow Dweng", b"mowdweng on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qma7X4nazFhRonoswCQzaXiehNthh6CFZ2AAPMDcdsDibg?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOWDWENG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOWDWENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOWDWENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

