module 0x76fefd5bc26f281a2c0b6f26e268c210cad5b818551dd62f635c0856556c2d7a::stanly {
    struct STANLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STANLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANLY>(arg0, 6, b"STANLY", b"Stanly Pig", b"Stanly is a cute pig, ready to make a big splash at the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009099_e320225ca7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STANLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STANLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

