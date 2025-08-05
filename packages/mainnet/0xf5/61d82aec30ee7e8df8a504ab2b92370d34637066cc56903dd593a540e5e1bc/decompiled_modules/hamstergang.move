module 0xf561d82aec30ee7e8df8a504ab2b92370d34637066cc56903dd593a540e5e1bc::hamstergang {
    struct HAMSTERGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSTERGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTERGANG>(arg0, 9, b"hamster", b"hamster gang", b"Twitter: https://x.com/ChinkIntel/status/1952815097815892027 | Website: https://www.tiktok.com/search?q=hamster%20sticker | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigx3awotmuu7p7ia5ux3pinkej5jsi2fqa3aqraqclbtvmiepyghu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAMSTERGANG>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTERGANG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTERGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

