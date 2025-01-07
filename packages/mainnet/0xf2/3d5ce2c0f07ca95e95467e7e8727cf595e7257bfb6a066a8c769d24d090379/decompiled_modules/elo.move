module 0xf23d5ce2c0f07ca95e95467e7e8727cf595e7257bfb6a066a8c769d24d090379::elo {
    struct ELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELO>(arg0, 6, b"Elo", b"chopsticks", b"To celebrate the successful release of recycling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Or_D0ovmf_400x400_4810b7545d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

