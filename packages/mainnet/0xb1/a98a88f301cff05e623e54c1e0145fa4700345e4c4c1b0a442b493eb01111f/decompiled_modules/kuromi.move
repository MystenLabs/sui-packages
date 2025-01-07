module 0xb1a98a88f301cff05e623e54c1e0145fa4700345e4c4c1b0a442b493eb01111f::kuromi {
    struct KUROMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUROMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUROMI>(arg0, 6, b"KUROMI", b"KUROMI ON SUI", b"In the spirit of Kuromi, $KUROMI risesa rebellious force shaped by community, bound by those who dare to dream differently.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_logo_5f7100e095.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUROMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUROMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

