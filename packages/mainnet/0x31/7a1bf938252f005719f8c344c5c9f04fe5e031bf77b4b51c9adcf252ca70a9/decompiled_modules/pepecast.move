module 0x317a1bf938252f005719f8c344c5c9f04fe5e031bf77b4b51c9adcf252ca70a9::pepecast {
    struct PEPECAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECAST>(arg0, 6, b"PEPECAST", b"PEPECAST ON SUI", b"The most memeable podcast ever existed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xca690af5607f20bbef53a41f3edc56683cad6eef_80a32b23ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

