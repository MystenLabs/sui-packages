module 0x8386ac2088b1fb0393aedcf4ea4fea835bca3c3fc909c7c0791f7def52e21c6b::bape {
    struct BAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPE>(arg0, 6, b"BAPE", b"Banana Penguin", b"Banana suit, Penguin vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bananaprof_449b8f98eb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

