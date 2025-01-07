module 0x8fbca6f071ecc5647380f2c9d849ac229c5c5da345b52afabd9faceb2c854c22::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"Michi", b"Michi the Matrix cat", b"Michi the Matrix Cat is a clever and enigmatic feline who has taken the internet by storm with her unique blend of mystique and meme-worthy charisma. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953066891.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MICHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

