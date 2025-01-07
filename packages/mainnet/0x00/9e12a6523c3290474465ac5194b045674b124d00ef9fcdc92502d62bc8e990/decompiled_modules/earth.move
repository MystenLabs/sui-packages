module 0x9e12a6523c3290474465ac5194b045674b124d00ef9fcdc92502d62bc8e990::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTH>(arg0, 6, b"EARTH", b"Sui Earth", b"The world will be more sophisticated than ever $EARHT is a good name for the universe, and we live on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052459_29993b4e43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

