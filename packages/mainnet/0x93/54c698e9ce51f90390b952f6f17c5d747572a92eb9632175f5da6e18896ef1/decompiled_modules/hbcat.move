module 0x9354c698e9ce51f90390b952f6f17c5d747572a92eb9632175f5da6e18896ef1::hbcat {
    struct HBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBCAT>(arg0, 6, b"HBCAT", b"Heavy Breathing Cat", b"Heavy Breathing Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040391_362a08abcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

