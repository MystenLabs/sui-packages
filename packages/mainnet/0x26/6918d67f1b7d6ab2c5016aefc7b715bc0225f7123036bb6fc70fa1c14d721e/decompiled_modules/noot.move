module 0x266918d67f1b7d6ab2c5016aefc7b715bc0225f7123036bb6fc70fa1c14d721e::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"NOOT O  SUI", b"NOOT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049652_6d9f260ee9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

