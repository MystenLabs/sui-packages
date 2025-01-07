module 0x685606417c276aedebe8d4a9dd3a32600bca08fe1d6ae3baab726b7fbbc8eeea::watch {
    struct WATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATCH>(arg0, 6, b"WATCH", b"Watch AI", b"\" $WATCH : Watch2Earn. Watch.Ai offers a revolutionary entertainment platform designed to transform your streaming experience into a truly rewarding journey. Whether that be from Netflix or Amazon prime content, immerse yourself in the world of entertainment as you watch your favourite movies and TV shows all while earning rewards! The very first Watch 2 Earn platform!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250106_001730_076_d998aff380.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

