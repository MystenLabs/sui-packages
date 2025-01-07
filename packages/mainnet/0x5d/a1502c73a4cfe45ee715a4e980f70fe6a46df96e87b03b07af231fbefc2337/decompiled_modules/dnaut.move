module 0x5da1502c73a4cfe45ee715a4e980f70fe6a46df96e87b03b07af231fbefc2337::dnaut {
    struct DNAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNAUT>(arg0, 6, b"DNAUT", b"DogAstronaut On Sui", b"$DNAUT - A meme coin inspired by astronauts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002146_b84568de75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNAUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

