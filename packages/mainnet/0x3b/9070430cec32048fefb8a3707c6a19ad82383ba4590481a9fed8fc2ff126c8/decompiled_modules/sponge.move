module 0x3b9070430cec32048fefb8a3707c6a19ad82383ba4590481a9fed8fc2ff126c8::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 6, b"SPONGE", b"SpongeBob", b"A meme coin for people who love SpongeBob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sponge_Bob_acb8df877b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

