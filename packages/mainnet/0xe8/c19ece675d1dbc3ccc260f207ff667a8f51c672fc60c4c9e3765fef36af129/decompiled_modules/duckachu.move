module 0xe8c19ece675d1dbc3ccc260f207ff667a8f51c672fc60c4c9e3765fef36af129::duckachu {
    struct DUCKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKACHU>(arg0, 6, b"DUCKACHU", b"Duckachu Duck", b"Meet Duckachu the first duck pokemon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhyhw2fvwbfvezvxes36fb6grubmeu4o233byz3bkwyaqofruxgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

