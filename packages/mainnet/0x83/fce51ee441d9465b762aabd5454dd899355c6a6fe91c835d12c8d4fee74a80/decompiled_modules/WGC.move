module 0x83fce51ee441d9465b762aabd5454dd899355c6a6fe91c835d12c8d4fee74a80::WGC {
    struct WGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WGC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WGC>>(v0);
    }

    public fun mint(arg0: WGC, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<WGC>, 0x2::coin::CoinMetadata<WGC>) {
        let (v0, v1) = 0x2::coin::create_currency<WGC>(arg0, 7, b"WGC", b"World Game Community", b"WGC are a team of serial founders, gamers, and crypto holders who believe in the benefits of gaming as a viable way of anyone to access transferable skills,social connection, and the global,digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-brilliant-canidae-863.mypinata.cloud/ipfs/bafkreihmoc5httviw5h3c5gyedi2qzh4jyqp657kwhu7m65wftitq7dziq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WGC>(&mut v2, 100000000000000000, @0xed531e44de21334d786a54eb159e24bdadc21fd0a8c44644b7394559ca4a1d15, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

