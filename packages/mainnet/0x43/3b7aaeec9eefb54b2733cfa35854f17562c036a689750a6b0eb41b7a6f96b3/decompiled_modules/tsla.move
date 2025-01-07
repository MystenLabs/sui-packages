module 0x433b7aaeec9eefb54b2733cfa35854f17562c036a689750a6b0eb41b7a6f96b3::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TSLA>, arg1: 0x2::coin::Coin<TSLA>) {
        0x2::coin::burn<TSLA>(arg0, arg1);
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 9, b"TSLA", b"TSLA6900", b"TSLA6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfPohKrPzBjQBEtrZiAt7qyKXT7beJe7BsMxbQFxWewdA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSLA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSLA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

