module 0xa79659c005ebabc862ae28ef77b54cb3b599155aa2fb087f4fb572fbdf686c4b::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"PUPPYSUI", b"Sui Network MEME project a The cutest dog in the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198024_edf08f7a0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

