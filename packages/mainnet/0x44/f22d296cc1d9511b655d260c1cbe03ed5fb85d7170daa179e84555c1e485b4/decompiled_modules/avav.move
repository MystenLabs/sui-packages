module 0x44f22d296cc1d9511b655d260c1cbe03ed5fb85d7170daa179e84555c1e485b4::avav {
    struct AVAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAV>(arg0, 6, b"AVAV", b"AVAV6969", b"Young people's first not serious, pay tribute to youth and desire!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8991_e316e86118.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

