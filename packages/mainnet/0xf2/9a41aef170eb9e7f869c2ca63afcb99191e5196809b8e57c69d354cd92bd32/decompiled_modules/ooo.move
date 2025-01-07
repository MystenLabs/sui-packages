module 0xf29a41aef170eb9e7f869c2ca63afcb99191e5196809b8e57c69d354cd92bd32::ooo {
    struct OOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOO>(arg0, 9, b"OOO", b"OOO", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

