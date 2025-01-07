module 0x74974ee2571df4f0a4cab78b4027aa49355e4267eb8ca70779c3c4a726d6b0ee::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 6, b"SDG", b"SUIDENG", b"SUI MOO DENG TIME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_8d85bfbca7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

