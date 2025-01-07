module 0x6cf009b69c2ca7dc756f43059bfbe4ef5bbb4b30063ca27442bb09ac2fd43f7::dumbo {
    struct DUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBO>(arg0, 6, b"DUMBO", b"Dumbo Octopus", b"DUMBO DUMBO DUMBO DUMBO DUMBO DUMBO DUMBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dumbo_228933ed7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

