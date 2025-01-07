module 0xc6c7e1e3772ae27915442cc0e36ebae48e3bbdf66e895075e46dffc193594a8e::lmoe {
    struct LMOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMOE>(arg0, 6, b"LMOE", b"Last Man on Earth", b"The last man on Earth standing in a desolate urban wasteland. Crumbling buildings and overgrown vegetation surround him, symbolizing the collapse of civilization. The dark, cloudy sky with a faint, glowing sun adds a somber and reflective atmosphere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732937826893.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

