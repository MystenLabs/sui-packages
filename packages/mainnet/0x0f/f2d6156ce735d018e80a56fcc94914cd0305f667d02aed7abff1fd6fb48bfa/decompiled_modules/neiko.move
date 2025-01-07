module 0xff2d6156ce735d018e80a56fcc94914cd0305f667d02aed7abff1fd6fb48bfa::neiko {
    struct NEIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIKO>(arg0, 6, b"NEIKO", b"NEIKOSUI", b"$NEIKO is a talisman of luck and wealth in Japan. There are rumors that interacting with $NEIKO will bring success to you. Hold $NEIKO cat and the fortune will smile on you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_182213_832_5279b2f4b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

