module 0x67df4fdda54fdd45aa50005ade5c7abe6112ef5507d4a5b1a51254e55c853309::swasti {
    struct SWASTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWASTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWASTI>(arg0, 9, b"SWASTI", b"Swasti Coin", b"Swasti Coin On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS1EfKZPqyFBWTFZi8V9h5tJ2E4oNeH9Gfaaz6pATpW6w")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWASTI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWASTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWASTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

