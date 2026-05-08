module 0x37e446c090f4f4f6a06c0caef51cddef2ae890013f001ec5054569eba99f9c7f::wallya {
    struct WALLYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLYA>(arg0, 6, b"WALLYA", b"WALLY", b"https://x.com/wearhelmet1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidzliieob6hmbc552x7ogqaoyi74zgungbkezigtqbcy3pmdn5d3y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLYA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

