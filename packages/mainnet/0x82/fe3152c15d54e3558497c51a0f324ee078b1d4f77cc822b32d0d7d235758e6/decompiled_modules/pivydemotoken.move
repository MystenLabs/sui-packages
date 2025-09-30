module 0x82fe3152c15d54e3558497c51a0f324ee078b1d4f77cc822b32d0d7d235758e6::pivydemotoken {
    struct PIVYDEMOTOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIVYDEMOTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PIVYDEMOTOKEN>>(0x2::coin::mint<PIVYDEMOTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PIVYDEMOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIVYDEMOTOKEN>(arg0, 9, b"PDT", b"PIVY Demo Token", b"PIVY Demo Token - A demonstration token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.filebase.io/ipfs/QmRJQkz2p2WaV1H6LkrZatkhWYLRRo5TQSvtaFeYJcjYt7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIVYDEMOTOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIVYDEMOTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIVYDEMOTOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

