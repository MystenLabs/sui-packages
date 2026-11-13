module 0x189b874036846b9fbb7593397597db85f217fdecdb6dd36d4dba403f1fd4f8b4::h {
    struct H has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<H>, arg1: 0x2::coin::Coin<H>) {
        0x2::coin::burn<H>(arg0, arg1);
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 6, b"H", b"HYDROGEN", b"THE FIRST ELEMENT ON THE PERIODIC TABLE. CAN BE CONVERTED INTO ANY OTHER ELEMENT WITH FUSION. COPYRIGHT 2026-2096 R.S.D.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid65472nqcjv63ahvt2tzhu37ntymx4emha73uakkabxcxkyvoi4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<H>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<H>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

