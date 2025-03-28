module 0xecd843b527a02b20aaf1c87d30ac5fe173a09a28bb6dc2f1bbcc4f78e045a005::bleu {
    struct BLEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEU>(arg0, 6, b"BLEU", b"Pepe Le Bleu", b"Pepe Le Bleu is the most emotionally unavailable memecoin on the market. Drenched in existential drip, rocking sad eyes, he's here to vibe, sigh dramatically, and maybe moon... if he feels like it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image1_5_89321256fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEU>>(v1);
    }

    // decompiled from Move bytecode v6
}

