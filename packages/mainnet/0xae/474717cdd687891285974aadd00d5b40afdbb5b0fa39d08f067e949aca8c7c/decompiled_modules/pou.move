module 0xae474717cdd687891285974aadd00d5b40afdbb5b0fa39d08f067e949aca8c7c::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"Gloomy Pou", b"$POU, your companion for any time and any place. With its charming personality and curious gaze, it brings lightness and fun to your day, whether its to cheer you up in tough moments or simply to be there when you need it. Always ready for an adventure or a quiet conversation, $POU is that loyal friend you can count on in any situation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_28_14_02_54_5dfa4cf4ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

