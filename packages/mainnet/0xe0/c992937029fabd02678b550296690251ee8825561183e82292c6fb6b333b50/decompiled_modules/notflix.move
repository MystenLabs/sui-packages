module 0xe0c992937029fabd02678b550296690251ee8825561183e82292c6fb6b333b50::notflix {
    struct NOTFLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTFLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTFLIX>(arg0, 6, b"NOTFLIX", b"NotFlix", b"Notflix ur trusted streaming site, but its a bit different, if u like movies or series, this coin is for you, come join our tg and grow a huge community that takes over SUI just like the movie industry!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3_30f38be193.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTFLIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTFLIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

