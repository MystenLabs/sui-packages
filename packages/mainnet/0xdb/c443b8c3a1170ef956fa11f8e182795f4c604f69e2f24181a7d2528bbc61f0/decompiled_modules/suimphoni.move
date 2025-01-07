module 0xdbc443b8c3a1170ef956fa11f8e182795f4c604f69e2f24181a7d2528bbc61f0::suimphoni {
    struct SUIMPHONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPHONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPHONI>(arg0, 6, b"SUIMPHONI", b"SYMPHONY of the SUI WORLD", b"$SUIMPHONI is your ticket to a magical world where dolphins dance in vibrant oceans under starlit skies and rainbow lands. Experience the harmony of this enchanting realm on Sui, and let the melodies of the sea guide your crypto journey. Dive in and embrace the magic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimphony_ba18e969b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPHONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPHONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

