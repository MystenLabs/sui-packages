module 0x6346d1705b340cbdbd0a8cdea22ed51f1c613f724769141fccaf9bdb7e4ce049::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"Dogelon", b"ELON Explores the greatest mysteries of the cryptoverse, join me together  we will reach the stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOGELON_f7a4ec9527.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

