module 0x40319277d4231a47854061e671c23e5de365c3de4474b5ddfe11163eecec404f::ghoulfin {
    struct GHOULFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOULFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOULFIN>(arg0, 6, b"Ghoulfin", b"Ghoul-fin", b"Ghoul-fin is the hauntingly playful Halloween fish token swimming through the Sui ecosystem! Inspired by ghostly depths and legendary sea creatures, Ghoul-fin brings a spooky yet captivating presence to the world of DeFi. This mysterious token offers holders thrilling seasonal rewards, eerie collectibles, and exclusive access to hidden realms within the Sui ecosystem. Ghoul-fin is perfect for collectors who revel in Halloween spirit, combining both haunting charm and deep-sea mystique. Dive into the Ghoul-fin wave and let the ghostly fins guide you to chilling profits and spectral surprises lurking in the blockchain depths!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_33712_1280_bda0589e42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOULFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOULFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

