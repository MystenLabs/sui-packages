module 0xc1fce4f9ad16373f62c2cab3be01c821b413af2e28e492272efb32023950d90b::jollyj {
    struct JOLLYJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLLYJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLLYJ>(arg0, 6, b"JOLLYJ", b"JOLLY JAGUAR", b"Leaping into the meme jungle with power and joy. Jolly Jaguar is a fierce competitor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_042529193_418456f3d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLLYJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLLYJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

