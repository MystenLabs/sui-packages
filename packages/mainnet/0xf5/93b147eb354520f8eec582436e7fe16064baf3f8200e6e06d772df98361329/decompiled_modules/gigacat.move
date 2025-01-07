module 0xf593b147eb354520f8eec582436e7fe16064baf3f8200e6e06d772df98361329::gigacat {
    struct GIGACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACAT>(arg0, 6, b"GIGACAT", b"Giga Cat", b"The giga cat of Sui is here to teach people to fcking hold or get smacked with his giga paws.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6097974204877094935_21f4b3022c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

