module 0xd03cfb4e614319bed8e71b82068ece97243849f4d65969e32330fa506f800faa::niggatue {
    struct NIGGATUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGATUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGATUE>(arg0, 6, b"NIGGATUE", b"Niggatue on Sui", b"We spent 4 days sculpting the Nigga Pepe Statue for Halloween, turning it into more than just a meme. It's a symbol. $NIGGATUE is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_5_2537514de4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGATUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGATUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

