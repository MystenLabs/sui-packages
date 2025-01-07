module 0x7cca11914d278594c55f1d3ab0627837faa6d84e629ddae34358e8893df4cdc5::badbrett {
    struct BADBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADBRETT>(arg0, 6, b"BADBRETT", b"Bad Brett Sui", b"Meet Bad Brett, the breathtakin' hero of SUI memes. His breath so powerful, it can moon tokens or clear out a room ! Wanna rich? Listen him, but don't forget ya nose plug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brett_200_1db303494f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

