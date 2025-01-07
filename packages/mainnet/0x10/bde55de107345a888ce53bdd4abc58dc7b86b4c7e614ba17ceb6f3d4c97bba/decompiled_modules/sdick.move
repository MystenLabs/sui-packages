module 0x10bde55de107345a888ce53bdd4abc58dc7b86b4c7e614ba17ceb6f3d4c97bba::sdick {
    struct SDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDICK>(arg0, 6, b"SDICK", b"Addicted - antimemecoin", b"Hold $DICK. Get hard fast. Antimemecoin on SuiNetwork that heals your addicktion from masturbating to charts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_19_02_58_a80d47187b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

