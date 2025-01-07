module 0xcf7923c9a692a58178a40e6f78798861bd25b34f9f41f25535ced8a570a598ad::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPY>(arg0, 6, b"HOPPY", b"Hoppy The Rabbit", b"$HOPPY is an innovative token inspired by the hop.fun mascot, a cheerful and dynamic rabbit that represents the freedom and fun of the cryptocurrency world. Featuring a captivating image of a hopping rabbit with a contagious smile, $HOPPY symbolizes the vibrant energy and united community surrounding hop.fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_05_25_10_8f0cde2c82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

