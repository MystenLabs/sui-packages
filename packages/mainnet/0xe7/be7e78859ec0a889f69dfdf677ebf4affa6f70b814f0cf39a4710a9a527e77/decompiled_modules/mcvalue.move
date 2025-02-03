module 0xe7be7e78859ec0a889f69dfdf677ebf4affa6f70b814f0cf39a4710a9a527e77::mcvalue {
    struct MCVALUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCVALUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCVALUE>(arg0, 9, b"McVALUE", b"McDonald's McVALUE", b"McDonald's earn your sunset for less with McValue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWFhVxadhcJ5hNvi4ahEhimkhBxCq7TdwA1gxGv39BJ1b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCVALUE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCVALUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCVALUE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

