module 0x3f919ecdd17958e7394db2c210eeaf9f180765f8e3582769ec10e5334cc86a1e::neirosui {
    struct NEIROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROSUI>(arg0, 6, b"Neirosui", b"NEIRO SUI", b"Neiro sui is meme coin following the momentum of  Neiro meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kitty_cat_kitten_pet_45201_ee347d783b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

