module 0x6ea3842f1939cf29fb79079a8976ab64aaa8b93e87075d4a93c8652a749722af::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"Bread", b"Bread Dolphin", b"its a dolphin made of bread", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bread_dolph_027eefc8b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

