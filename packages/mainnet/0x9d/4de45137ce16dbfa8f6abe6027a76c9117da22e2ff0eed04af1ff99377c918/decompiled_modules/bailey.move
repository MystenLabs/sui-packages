module 0x9d4de45137ce16dbfa8f6abe6027a76c9117da22e2ff0eed04af1ff99377c918::bailey {
    struct BAILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAILEY>(arg0, 6, b"BAILEY", b"Bailey on Sui", b"Baileys been making quiet moves, and the impact is about to be huge. When someone like that steps in, you know something big is about to unfold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/abf8c45p_400x400_d0dfda289e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAILEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

