module 0xf5d2e04b0eeeb942fb6a1baedc2aa5a0c6956e40c9389482a385956a1abc81d8::kylo {
    struct KYLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYLO>(arg0, 6, b"KYLO", b"Kylo the dog", b"Iconic white colored dog pulls in a memento dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055365_e3814d1bfb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

