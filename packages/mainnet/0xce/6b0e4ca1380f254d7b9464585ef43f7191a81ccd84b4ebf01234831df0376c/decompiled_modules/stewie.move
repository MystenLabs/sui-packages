module 0xce6b0e4ca1380f254d7b9464585ef43f7191a81ccd84b4ebf01234831df0376c::stewie {
    struct STEWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEWIE>(arg0, 9, b"STEWIE", b"Stewie", b"Stewie Griffin storms the memecoin market with his trademark sass and smarts , promising a future as right as his wit.!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xd951fad8996088bf3a6eefd71a6dae8afffb8d3d.png?size=xl&key=46e9a5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEWIE>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEWIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

