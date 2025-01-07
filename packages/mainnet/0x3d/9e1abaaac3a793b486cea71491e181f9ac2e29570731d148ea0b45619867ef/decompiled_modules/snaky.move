module 0x3d9e1abaaac3a793b486cea71491e181f9ac2e29570731d148ea0b45619867ef::snaky {
    struct SNAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKY>(arg0, 9, b"SNAKY", b"Snaky", x"536e61636b2066697273742c207468696e6b206e6576657220f09fa48e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6mv5U2o8eZvm1stKkujmQ3yg9gEGyCoNz7AK7mLSpump.png?size=lg&key=4f90fb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNAKY>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

