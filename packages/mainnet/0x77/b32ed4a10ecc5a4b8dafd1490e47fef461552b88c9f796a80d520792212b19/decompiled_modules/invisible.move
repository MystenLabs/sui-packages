module 0x77b32ed4a10ecc5a4b8dafd1490e47fef461552b88c9f796a80d520792212b19::invisible {
    struct INVISIBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVISIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVISIBLE>(arg0, 6, b"INVISIBLE", b"INVISIBLE SUI", b"in honor of those invisible friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0291_9292109da1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVISIBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INVISIBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

