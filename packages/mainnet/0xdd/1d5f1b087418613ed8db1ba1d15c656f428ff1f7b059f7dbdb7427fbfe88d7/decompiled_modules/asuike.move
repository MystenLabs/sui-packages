module 0xdd1d5f1b087418613ed8db1ba1d15c656f428ff1f7b059f7dbdb7427fbfe88d7::asuike {
    struct ASUIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIKE>(arg0, 6, b"ASUIKE", b"Asuike", b"In feudal Japan, there lived a black shiba inu named Asuike, known as the \"Samurai of the Shadows.\" Orphaned, he was taken in by Master Yamada, a former warrior who taught him the art of the sword and the principles of Bushido. With his ink-black fur and golden eyes, Asuike was no ordinary dog. Armed with a miniature katana, he protected his village from bandits and demonic creatures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_37_24_e9652aafa3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

