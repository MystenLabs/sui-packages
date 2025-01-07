module 0x673bf38ee68b31d65900d27b64423c7aa40760847d2ab36d83ee37a70161d32e::elmnt {
    struct ELMNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMNT>(arg0, 9, b"ELMNT", b"Element 280", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xe9a53c43a0b58706e67341c4055de861e29ee943.png?size=xl&key=faaf53")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELMNT>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMNT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELMNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

