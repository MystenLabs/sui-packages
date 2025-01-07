module 0x6cad0afd59444dba96e7f5f769f7bc4d5522a2483730d427208cfb65b9a303a2::sbdn {
    struct SBDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBDN>(arg0, 6, b"SBDN", b"SUIBODEN", b"BODEN TOKEN MEME GODDDDDDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boden_5ebf356f6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

