module 0x73d0d718565b68b9ea90402adc861624c43b83d0ce104dfb5105076eaaf2f65b::thecomeback {
    struct THECOMEBACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THECOMEBACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THECOMEBACK>(arg0, 9, b"comeback", b"the comeback", b"the comeback is real. | Twitter: https://x.com/i/communities/1954433342671077401 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqskr5aunw5f4fqbwo6zgunr4y6nd7vdhpjmmqrof5vpsgyr3kbm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THECOMEBACK>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THECOMEBACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THECOMEBACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

