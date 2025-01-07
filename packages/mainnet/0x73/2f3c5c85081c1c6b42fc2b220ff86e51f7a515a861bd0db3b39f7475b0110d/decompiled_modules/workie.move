module 0x732f3c5c85081c1c6b42fc2b220ff86e51f7a515a861bd0db3b39f7475b0110d::workie {
    struct WORKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORKIE>(arg0, 9, b"WORKIE", b"Workie", b"Community Claim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x7480527815ccae421400da01e052b120cc4255e9.png?size=lg&key=80c012")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WORKIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORKIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

