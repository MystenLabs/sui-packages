module 0x72063a55eb449e31d4b66d7836400f0a6e32e655c90ccb71fe73d7cd4dc1f805::gbdg {
    struct GBDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBDG>(arg0, 6, b"GBDG", b"GIGGLY BADGER", b"Always laughing, always winning. Giggly Badger is clawing its way to meme stardom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_030745061_c2c29bbab7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

