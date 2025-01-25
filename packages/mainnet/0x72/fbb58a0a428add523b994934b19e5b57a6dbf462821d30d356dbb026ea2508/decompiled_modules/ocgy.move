module 0x72fbb58a0a428add523b994934b19e5b57a6dbf462821d30d356dbb026ea2508::ocgy {
    struct OCGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCGY>(arg0, 6, b"OCGY", b"OCTOPUS ENERGY", b"Join the $OCGY most popular energy supplier", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029616_53705e092c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

