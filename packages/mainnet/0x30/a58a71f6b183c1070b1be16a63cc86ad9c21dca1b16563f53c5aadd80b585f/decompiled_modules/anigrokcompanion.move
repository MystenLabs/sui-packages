module 0x30a58a71f6b183c1070b1be16a63cc86ad9c21dca1b16563f53c5aadd80b585f::anigrokcompanion {
    struct ANIGROKCOMPANION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIGROKCOMPANION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIGROKCOMPANION>(arg0, 9, b"Ani", b"Ani Grok Companion", b"Website: https://x.com/techdevnotes/status/1944706304594862217 | Twitter: https://x.com/techdevnotes/status/1944706304594862217 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5kogx5jxnw6zzyyxxv66pokswuj32z2y34ut53druz2qwzdvs7u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANIGROKCOMPANION>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIGROKCOMPANION>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIGROKCOMPANION>>(v1);
    }

    // decompiled from Move bytecode v6
}

