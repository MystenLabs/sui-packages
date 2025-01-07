module 0x1dbad65c6cf1243cc0bf07c6b2865ce450e34d210e22e1c7f2093ab2ea238df5::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 9, b"DICK", x"28e280afcd9c2e20e38585e280afcd9c2e2029f09fa59b2079756d794449434b", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DICK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

