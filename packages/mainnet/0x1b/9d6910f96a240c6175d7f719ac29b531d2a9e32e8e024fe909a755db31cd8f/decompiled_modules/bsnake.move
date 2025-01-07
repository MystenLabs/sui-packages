module 0x1b9d6910f96a240c6175d7f719ac29b531d2a9e32e8e024fe909a755db31cd8f::bsnake {
    struct BSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSNAKE>(arg0, 6, b"BSNAKE", b"Blue Eyed Snake", b"Blue eyed snake, destroyer of jeets. Pumper of charts. The legend has come true. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2050_10fa559aa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

