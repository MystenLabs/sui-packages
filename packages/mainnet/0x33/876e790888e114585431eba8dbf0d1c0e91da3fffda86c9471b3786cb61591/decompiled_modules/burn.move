module 0x33876e790888e114585431eba8dbf0d1c0e91da3fffda86c9471b3786cb61591::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"BurnPlay", b"Play Hard, Burn Smart, Claim SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiesgr5na2n5xnfz4nq63vt3bnyd4tj4nqmkzsgpweo7n2zsxmzxm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

