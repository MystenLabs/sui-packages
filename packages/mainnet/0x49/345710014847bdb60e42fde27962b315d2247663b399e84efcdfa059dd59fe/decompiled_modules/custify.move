module 0x49345710014847bdb60e42fde27962b315d2247663b399e84efcdfa059dd59fe::custify {
    struct CUSTIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSTIFY>(arg0, 6, b"Custify", b"Custify AI", b"Custify AI is a customer service agent powered by advanced Artificial Intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2361_014f38a134.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUSTIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

