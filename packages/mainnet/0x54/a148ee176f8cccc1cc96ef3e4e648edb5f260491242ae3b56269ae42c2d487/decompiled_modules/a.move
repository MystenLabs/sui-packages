module 0x54a148ee176f8cccc1cc96ef3e4e648edb5f260491242ae3b56269ae42c2d487::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"Acuva AI", b"Decentralized AI agents built for speed, precision, and seamless collaboration. Acuva AI transforms complexity into clarity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250114_032445_198_a507992353.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A>>(v1);
    }

    // decompiled from Move bytecode v6
}

