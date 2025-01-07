module 0x607350c961722e8b63b7447e9223b519461c36df923e9c9e1a47387e02471d2a::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"Anon", b"Anonymous Cat", b"cat is anonymous - no team no socials just the power of the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0663_d36fe5b08d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

