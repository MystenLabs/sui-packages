module 0x79507a1163e32253b9655474860e370e77530db3d66bd7579614fc3a23a32b8f::noellingscult {
    struct NOELLINGSCULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOELLINGSCULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOELLINGSCULT>(arg0, 9, b"Noelle", b"Noellings Cult", b"Twitter: https://x.com/i/communities/1949417595871830069 | Website: https://www.tiktok.com/@certainly0ci/video/7530914602847046943 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqnywnlxhp2ultrzpiikx7zyrljxo7cc2np4mowhubdmcw4wij34")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOELLINGSCULT>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOELLINGSCULT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOELLINGSCULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

