module 0x6e513878c1e1e0417d68447389e369613a84c8fbe619eabd6f616413a8f90b7b::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"Shiba", b"shibadogs", b"Zoo take off", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0698_2adc92ca99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

