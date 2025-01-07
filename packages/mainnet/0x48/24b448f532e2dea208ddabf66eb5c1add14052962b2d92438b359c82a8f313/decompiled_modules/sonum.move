module 0x4824b448f532e2dea208ddabf66eb5c1add14052962b2d92438b359c82a8f313::sonum {
    struct SONUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONUM>(arg0, 6, b"SONUM", b"SOLANUM", b"Meme Buy hold sell take profits.tomato, (Solanum lycopersicum), flowering plant of the nightshade family (Solanaceae), cultivated extensively for its edible fruits.Like the potato, tomatoes belong to the genus Solanum, which is a member of the nightshade family, the Solanaceae.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1908_bdbf5338c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

