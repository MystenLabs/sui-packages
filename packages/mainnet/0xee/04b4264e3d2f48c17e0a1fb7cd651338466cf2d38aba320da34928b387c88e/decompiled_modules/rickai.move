module 0xee04b4264e3d2f48c17e0a1fb7cd651338466cf2d38aba320da34928b387c88e::rickai {
    struct RICKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKAI>(arg0, 6, b"RickAI", b"Rick AI", b"RickAI is the biggest AI on Solana, hes the ultimate gateway to interdimensional gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250113_073852_374_c46630991c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

