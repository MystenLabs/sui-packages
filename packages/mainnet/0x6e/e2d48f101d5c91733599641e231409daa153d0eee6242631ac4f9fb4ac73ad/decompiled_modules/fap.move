module 0x6ee2d48f101d5c91733599641e231409daa153d0eee6242631ac4f9fb4ac73ad::fap {
    struct FAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAP>(arg0, 6, b"FAP", b"PUBERTY", b"Cause no matter how old u r", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_10_dac1df47b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

