module 0x1493d63d502428e47930bbd2b7dc4c7a0ab15ee51ca44a1cfeb37fbf1563becb::suiverse {
    struct SUIVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVERSE>(arg0, 6, b"SUIVERSE", b"Suiverse of Cats", b"Suiverse of Cats is a whimsical digital realm where cats reign supreme on the Sui blockchain. Filled with adventurous felines exploring decentralized lands, this universe is driven by a community of cat lovers who trade, collect, and celebrate all things feline. From sleek hunters to mischievous kittens, the Suiverse is a playful, ever-evolving world where every cat has a storyand maybe even a coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10_30_50pcs_Cute_Cats_Stickers_Funny_Famous_Cat_Meme_Catoon_Decal_DIY_Notebook_Phone_Phone_90f2f3af3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

