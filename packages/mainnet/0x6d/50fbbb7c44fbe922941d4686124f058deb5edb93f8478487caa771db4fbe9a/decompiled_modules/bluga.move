module 0x6d50fbbb7c44fbe922941d4686124f058deb5edb93f8478487caa771db4fbe9a::bluga {
    struct BLUGA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUGA>, arg1: 0x2::coin::Coin<BLUGA>) {
        0x2::coin::burn<BLUGA>(arg0, arg1);
    }

    fun init(arg0: BLUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUGA>(arg0, 9, b"BLUGA", b"Baby Luga", b"Baby Luga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfPohKrPzBjQBEtrZiAt7qyKXT7beJe7BsMxbQFxWewdA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUGA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

