module 0x2b6a662fee2ab777e6c7222195b00d2997ebfc9163fa08ba15af3e40cc6ab0b8::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"BLUEY", b"Bluey", b"Bluey is a memecoin project inspired by the popular Australian cartoon that follows the adventures of Bluey, a cheerful and imaginative Blue Heeler puppy. The project aims to create a fun and active community while leveraging elements of gaming and social interaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_a9e5818f09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

