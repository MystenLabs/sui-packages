module 0xfe27deb4f1eca79cef786d754064593a6c5b2bc8d16218a6d5a977b03912ab9e::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 9, b"BLOBO", b"Sui Blobo", b"\"Blobo\" refers to an exploitable MS Paint image of a blobfish frequently posted on 4chan and other forums with the sentence, \"BLOBO IS NEW MEME\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmVfp6f3u9G3yNRNhmr8EzviCNJu3F6twfCaMA3QhMaxAY?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOBO>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

