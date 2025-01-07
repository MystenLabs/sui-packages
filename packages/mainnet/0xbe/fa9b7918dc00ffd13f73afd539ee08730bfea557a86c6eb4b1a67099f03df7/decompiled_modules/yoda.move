module 0xbefa9b7918dc00ffd13f73afd539ee08730bfea557a86c6eb4b1a67099f03df7::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"YODA SUI", b"YODA COMING SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_16_9279b65254.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

