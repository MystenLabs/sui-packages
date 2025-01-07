module 0x70192dfc23bc702d84fb0a92439d05c87d04356ee5b41344510d11cf157d7858::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 6, b"Suu", b"Suuflex on SUI", b"good token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsadsa_ca6a19f1a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

