module 0x4a958e0af9a14be927ce5fc38bb03a8f662406a9ed1fe427686eaa4aad5305ee::house {
    struct HOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOUSE>(arg0, 6, b"HOUSE", b"Sui Housecoin", b"Housecoin On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicf2pwi2qnww3eplidddg7rrt72k4kwrtgwkz2ukbumuhl2hyopo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

