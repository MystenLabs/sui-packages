module 0x4ac86239a62324c50c76f79f69a5132ddf09800c1a8781f23b2805d339f80dc1::suidolphine {
    struct SUIDOLPHINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOLPHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOLPHINE>(arg0, 6, b"SUIDOLPHINE", b"Sui Dolphins", b"Dolphins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_09_50_56_e940ffcd52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOLPHINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOLPHINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

