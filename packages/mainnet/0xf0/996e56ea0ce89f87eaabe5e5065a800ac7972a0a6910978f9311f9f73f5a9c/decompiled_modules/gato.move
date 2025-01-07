module 0xf0996e56ea0ce89f87eaabe5e5065a800ac7972a0a6910978f9311f9f73f5a9c::gato {
    struct GATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATO>(arg0, 6, b"GATO", b"Gato on Sui", b"Gatto will be the first original cat meme coin project to be released on the #sui network. Take your place before it's too late. By the way, we are sorry if the #solana community gets jealous.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039970_58b434892f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

