module 0xbfff63bb8a8f001b5a7490d2a9a22718b9ef58d9e0d1de0a24639efafe0623fb::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 6, b"LIQ", b"Liquor", b"Be liquor, my friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LIQ>(&mut v2, 69696969696000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

