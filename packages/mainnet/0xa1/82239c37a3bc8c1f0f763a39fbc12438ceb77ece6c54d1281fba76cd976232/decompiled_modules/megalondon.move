module 0xa182239c37a3bc8c1f0f763a39fbc12438ceb77ece6c54d1281fba76cd976232::megalondon {
    struct MEGALONDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGALONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGALONDON>(arg0, 6, b"MEGALONDON", b"MEGALONDON SUI", b"Welcome to the underwater world of Megalodon, where the Megalodon shark reigns supreme as the ultimate mafia godfather of the crypto ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9c43f9f4bfa71980910e1004158582e1ffcfd86aa373d8a1854859794ded6421_meg_meg_8ec551711c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGALONDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGALONDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

