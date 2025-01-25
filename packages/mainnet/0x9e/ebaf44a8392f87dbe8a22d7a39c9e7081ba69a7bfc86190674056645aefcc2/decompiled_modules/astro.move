module 0x9eebaf44a8392f87dbe8a22d7a39c9e7081ba69a7bfc86190674056645aefcc2::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 6, b"ASTRO", b"AstroAI Relaunch", x"5265626f726e20616e64207374726f6e6765722e20417374726f41492069732061207375636365737366756c206578706572696d656e74206f6620414920746563686e6f6c6f676965732e204a6f696e206f757220636f6d6d756e69747920746f2074616c6b207769746820417374726f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/astroai2_1_f1b1fe904f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

