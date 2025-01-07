module 0xf619c75c7d29c44de1e670d9ca40239bba0ca804fbe00feb6f1dd0170d3386ea::svirus {
    struct SVIRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVIRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVIRUS>(arg0, 9, b"SVIRUS", b"Sui Virus", b"https://telegra.ph/Virus-Coin-On-Sui-10-09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844031250983784448/_WycaNmZ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SVIRUS>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVIRUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVIRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

