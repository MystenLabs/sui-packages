module 0xa8609c20f3aa47845d7971c76dc6198598586e928cc7adc34965e94b018a3647::crazycrab {
    struct CRAZYCRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZYCRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZYCRAB>(arg0, 6, b"CRAZYCRAB", b"CrazyCrab", b"Just a degen crab living in the SUI Ocean ready to write history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_38_39_eaddc23948.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZYCRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZYCRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

