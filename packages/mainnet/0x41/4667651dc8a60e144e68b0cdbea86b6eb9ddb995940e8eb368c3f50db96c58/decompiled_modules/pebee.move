module 0x414667651dc8a60e144e68b0cdbea86b6eb9ddb995940e8eb368c3f50db96c58::pebee {
    struct PEBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEBEE>(arg0, 6, b"PEBEE", b"Sui Pebee", b"$PEBEE for the people. The sweetest token on SUI. Our community is bonded together with honey ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048448_a37a6ea9b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEBEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEBEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

