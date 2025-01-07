module 0x48f0df93a9491f415d746e13b9db70cc08060b1ada198e96858bc908903bf5fa::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 6, b"GAGA", b"GAGA SUI", b"The new meme coin heroine Gaga joins forces with Pepe to tackle memecoin dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb29dc1703facd2967bb8ade2e392385644c6dca9_35c376ded9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

