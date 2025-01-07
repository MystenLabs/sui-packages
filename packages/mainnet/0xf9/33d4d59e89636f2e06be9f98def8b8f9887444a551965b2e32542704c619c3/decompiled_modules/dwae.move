module 0xf933d4d59e89636f2e06be9f98def8b8f9887444a551965b2e32542704c619c3::dwae {
    struct DWAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWAE>(arg0, 9, b"DWAE", b"Ugnada Kunkles", b"come wit me bruda $DWAE is on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x8af47a8aa1934f98ac1564f51c19e03809533f19.png?size=xl&key=c28985")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DWAE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWAE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

