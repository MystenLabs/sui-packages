module 0x3206dcec06788f317471590c59d8ad90fab04be90d12ac5903d8b225289b9dd1::suitato {
    struct SUITATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATO>(arg0, 6, b"Suitato", b"Suitato the potato in a suit on SUI", b"Suitato, the potato in a suit on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_1_9af37181b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

