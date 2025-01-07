module 0x3f0d1405512db5c635bad7853e25b3eb6cb2ce0585095171a13956041dfcbb9e::smpsui {
    struct SMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMPSUI>(arg0, 6, b"Smpsui", b"Simpson sui", b"You want 100x ? Wait sold after list in move ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1ecde349_0e3b_41aa_b812_b6b3f1deee42_0087be2aaa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

