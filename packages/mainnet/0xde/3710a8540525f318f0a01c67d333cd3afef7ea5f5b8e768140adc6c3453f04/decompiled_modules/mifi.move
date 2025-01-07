module 0xde3710a8540525f318f0a01c67d333cd3afef7ea5f5b8e768140adc6c3453f04::mifi {
    struct MIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIFI>(arg0, 6, b"MIFI", b"MIFI on SUI", b"Mifi, a weasel in Sui world...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027438_320467ba43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

