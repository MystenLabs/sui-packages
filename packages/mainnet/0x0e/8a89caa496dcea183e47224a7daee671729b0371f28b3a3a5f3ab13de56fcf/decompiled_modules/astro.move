module 0xe8a89caa496dcea183e47224a7daee671729b0371f28b3a3a5f3ab13de56fcf::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 6, b"ASTRO", b"AstroAI 3.0", b"AstroAI is a successful experiment of AI technologies. Join our community to talk with Astro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/astroai2_1_ddc733b2b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

