module 0xa7a1bae610796f2b42ec6ddc139c191195c1f34f1f6f7f9ebbe2f9705507f53b::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASTRO>(arg0, 6, b"ASTRO", b"AstroAI", b"AstroAI is a successful experiment of AI technologies. Join our community to talk with Astro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b31592a7_160f_40e7_9fdb_820d4e2f901b_f3ef9ac425.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

