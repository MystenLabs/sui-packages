module 0x41745ee237d77f8289c048b63eeb674c8ce8a678fb41aa4f0c1f9350d9815a49::girby {
    struct GIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRBY>(arg0, 6, b"GIRBY", b"GirbyOnSui", b"$GIRBY is the meme coin that laughs through the crypto chaossatirizing market madness, uniting traders, and turning losses into legendary memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aucuf4_064d7a1411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

