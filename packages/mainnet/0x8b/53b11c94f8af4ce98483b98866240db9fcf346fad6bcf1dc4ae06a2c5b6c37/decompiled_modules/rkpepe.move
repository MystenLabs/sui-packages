module 0x8b53b11c94f8af4ce98483b98866240db9fcf346fad6bcf1dc4ae06a2c5b6c37::rkpepe {
    struct RKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKPEPE>(arg0, 6, b"RKPEPE", b"Rickpepe on Sui", b"$RKPEPE is the meme coin that blends Pepe's charm with crypto hypefun, fresh, and fueled by community vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rk_7ded1379b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

