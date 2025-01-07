module 0x1d83b2558f4729a38e109ca79f38369e4b424dfad30f1bee8d04a87abebf081d::shamu {
    struct SHAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMU>(arg0, 9, b"Shamu", b"Shamu", b"To The moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FcTQLH1TBnxpBMKgSgVeswY8SCRv4B28nMKF88jWpump.png?size=xl&key=95196b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHAMU>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

