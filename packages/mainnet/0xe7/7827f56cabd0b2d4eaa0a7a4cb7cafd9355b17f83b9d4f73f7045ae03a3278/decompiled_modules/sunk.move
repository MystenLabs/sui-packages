module 0xe77827f56cabd0b2d4eaa0a7a4cb7cafd9355b17f83b9d4f73f7045ae03a3278::sunk {
    struct SUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNK>(arg0, 6, b"SUNK", b"SunkOnSui", x"796f75206569746865722073696e6b0a0a4f5220474554202453554e4b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sunk_On_Sui_2f3e80feba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

