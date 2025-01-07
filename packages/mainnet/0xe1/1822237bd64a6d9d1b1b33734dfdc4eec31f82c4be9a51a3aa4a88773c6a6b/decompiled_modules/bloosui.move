module 0xe11822237bd64a6d9d1b1b33734dfdc4eec31f82c4be9a51a3aa4a88773c6a6b::bloosui {
    struct BLOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOSUI>(arg0, 6, b"BLOOSUI", b"BLOO SUI", b"BLOO IT  TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x221c90b7ae2af88b38b4fdb58833f833b2788984a1666c120393bea25b21163f_bloo_bloo_464e5be885.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

