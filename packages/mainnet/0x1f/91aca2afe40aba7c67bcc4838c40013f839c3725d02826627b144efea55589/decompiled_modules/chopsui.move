module 0x1f91aca2afe40aba7c67bcc4838c40013f839c3725d02826627b144efea55589::chopsui {
    struct CHOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOPSUI>(arg0, 6, b"ChopSui", b"Chop Panda Sui", b"PLAY, CHOP, EARN Powered by $SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiex3lzq2k2rgzrumykkpmnb4luyp6xpqwzpbb4exsg2jgxpbfpvpq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

