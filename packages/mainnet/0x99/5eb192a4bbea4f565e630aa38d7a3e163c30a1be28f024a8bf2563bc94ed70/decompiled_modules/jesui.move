module 0x995eb192a4bbea4f565e630aa38d7a3e163c30a1be28f024a8bf2563bc94ed70::jesui {
    struct JESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUI>(arg0, 6, b"JESUI", b"Jesui Luv", b"Blessed be the hands that hold Sui, for Jesui watches over them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7f535d27_8028_4d5b_97c5_6be586cf1eed_bf2d09ad05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

