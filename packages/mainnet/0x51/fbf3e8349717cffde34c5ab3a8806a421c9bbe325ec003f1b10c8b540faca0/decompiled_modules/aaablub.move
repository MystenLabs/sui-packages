module 0x51fbf3e8349717cffde34c5ab3a8806a421c9bbe325ec003f1b10c8b540faca0::aaablub {
    struct AAABLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABLUB>(arg0, 6, b"AAABLUB", b"aaaBLUB", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blub_22cf91bb32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

