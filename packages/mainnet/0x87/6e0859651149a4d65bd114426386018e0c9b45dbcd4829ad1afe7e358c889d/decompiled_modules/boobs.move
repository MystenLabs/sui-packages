module 0x876e0859651149a4d65bd114426386018e0c9b45dbcd4829ad1afe7e358c889d::boobs {
    struct BOOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS>(arg0, 6, b"BOOBS", b"Boob Lover", b"Loving boobs everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049191_6c64898dac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

