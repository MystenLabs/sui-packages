module 0x7be4d556ed3dd25283fff67bdf8882ace30a4034919f76b7506228bda7e75ce8::sagmilisa {
    struct SAGMILISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGMILISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGMILISA>(arg0, 6, b"SAGMILISA", b"monawifsagmihat", b"Put on a hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dgssg_ed7d799372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGMILISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGMILISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

