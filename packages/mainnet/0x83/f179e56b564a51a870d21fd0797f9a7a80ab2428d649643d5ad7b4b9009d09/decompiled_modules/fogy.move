module 0x83f179e56b564a51a870d21fd0797f9a7a80ab2428d649643d5ad7b4b9009d09::fogy {
    struct FOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOGY>(arg0, 6, b"FOGY", b"Fogy", b"The most famous frog on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FOGY_7d44d4a489.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

