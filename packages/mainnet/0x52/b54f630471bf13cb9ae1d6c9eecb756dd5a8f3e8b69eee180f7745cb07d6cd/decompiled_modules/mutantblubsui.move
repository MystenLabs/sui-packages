module 0x52b54f630471bf13cb9ae1d6c9eecb756dd5a8f3e8b69eee180f7745cb07d6cd::mutantblubsui {
    struct MUTANTBLUBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTANTBLUBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTANTBLUBSUI>(arg0, 6, b"MutantBlubSUI", b"MutantBlubSui", b"Mutant Blub is a playful and quirky meme coin inspired by a muted fish that quietly exists in the vast ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/31e99w9ad9a9da_c639474ee3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTANTBLUBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTANTBLUBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

