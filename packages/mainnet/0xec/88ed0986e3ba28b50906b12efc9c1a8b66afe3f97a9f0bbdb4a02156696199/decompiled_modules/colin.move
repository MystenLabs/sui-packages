module 0xec88ed0986e3ba28b50906b12efc9c1a8b66afe3f97a9f0bbdb4a02156696199::colin {
    struct COLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLIN>(arg0, 6, b"COLIN", b"Sui Colin", b"Hi I'm colin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026513_e580a2eeb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

