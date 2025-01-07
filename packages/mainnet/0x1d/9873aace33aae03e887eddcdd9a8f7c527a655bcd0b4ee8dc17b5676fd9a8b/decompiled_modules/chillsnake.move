module 0x1d9873aace33aae03e887eddcdd9a8f7c527a655bcd0b4ee8dc17b5676fd9a8b::chillsnake {
    struct CHILLSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSNAKE>(arg0, 6, b"ChillSnake", b"Just Chill Snake", b"JOIN FORCES WITH CHILL SNAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735314837537.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSNAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSNAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

