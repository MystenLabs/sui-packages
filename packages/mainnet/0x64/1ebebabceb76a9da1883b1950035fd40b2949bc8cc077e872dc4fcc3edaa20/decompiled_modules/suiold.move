module 0x641ebebabceb76a9da1883b1950035fd40b2949bc8cc077e872dc4fcc3edaa20::suiold {
    struct SUIOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOLD>(arg0, 6, b"SUIOLD", b"Suiold coin", b"Old", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaepj23yljar5662i6mqmwwjzvgqepii6az3snmita76oxixs6qli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

