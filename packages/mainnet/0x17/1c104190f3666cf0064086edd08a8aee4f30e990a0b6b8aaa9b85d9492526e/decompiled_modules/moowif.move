module 0x171c104190f3666cf0064086edd08a8aee4f30e990a0b6b8aaa9b85d9492526e::moowif {
    struct MOOWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOWIF>(arg0, 6, b"MOOWIF", b"Moodengwifhat", b"Jus a moo deng wif a hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036281_955d08b395.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

