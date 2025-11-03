module 0xf0d81b3af4dcfada9b3c4628c5ef08bf467230ba6d80c4b59dbcd297d2a9b084::new_usdt {
    struct NEW_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_USDT>(arg0, 6, b"USDT", b"tafrt", b"Tokens for having fun among friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdmzy6umk5drqgmaa7fti73thnxiy5c6hxcqqc4g72yfldv42weu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEW_USDT>(&mut v2, 666600000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_USDT>>(v2, @0xfcbc7937578ca5697f9332d37876ece3fc647867671a5c9e7c6869ae3924ee26);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEW_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

