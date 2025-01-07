module 0x1a7dbe532b1749b8e3086a2df387b9af961dd1b040b19e905d86139d6a1dc2bf::gory {
    struct GORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORY>(arg0, 6, b"GORY", b"Gory The Goats", b"Gory, the lucky goat. Bringing good fortune and share that luck with all of humanity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HEAD_376b74db49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

