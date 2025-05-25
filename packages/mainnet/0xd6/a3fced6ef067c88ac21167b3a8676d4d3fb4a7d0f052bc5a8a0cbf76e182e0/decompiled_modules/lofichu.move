module 0xd6a3fced6ef067c88ac21167b3a8676d4d3fb4a7d0f052bc5a8a0cbf76e182e0::lofichu {
    struct LOFICHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFICHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFICHU>(arg0, 6, b"Lofichu", b"Lofi Pikachu", b"Lofi The Pikachu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibav34zyva7eqrzb76ritbkflditsrvmkt7aojlnjab6ttcrlrqjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFICHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOFICHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

