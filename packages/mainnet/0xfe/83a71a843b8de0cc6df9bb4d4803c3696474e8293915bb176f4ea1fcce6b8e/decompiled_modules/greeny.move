module 0xfe83a71a843b8de0cc6df9bb4d4803c3696474e8293915bb176f4ea1fcce6b8e::greeny {
    struct GREENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENY>(arg0, 6, b"GREENY", b"Greeny King", b"GM  Greeny is created with hopes and dreams to join the Crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021151_b9fb0218a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

