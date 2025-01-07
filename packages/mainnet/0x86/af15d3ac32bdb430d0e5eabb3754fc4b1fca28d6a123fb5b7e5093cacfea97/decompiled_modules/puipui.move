module 0x86af15d3ac32bdb430d0e5eabb3754fc4b1fca28d6a123fb5b7e5093cacfea97::puipui {
    struct PUIPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUIPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUIPUI>(arg0, 9, b"PUIPUI", b"PUIPUI", b"Make Pepe Greate Again on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x6982508145454ce325ddbe47a25d4ec3d2311933.png?size=lg&key=7d789c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUIPUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIPUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUIPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

