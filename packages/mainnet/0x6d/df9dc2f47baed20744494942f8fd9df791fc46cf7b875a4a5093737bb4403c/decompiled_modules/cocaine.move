module 0x6ddf9dc2f47baed20744494942f8fd9df791fc46cf7b875a4a5093737bb4403c::cocaine {
    struct COCAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCAINE>(arg0, 6, b"COCAINE", b"THE GOOD STUFF", b"May cause extreme profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coke_77f7ab886c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCAINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCAINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

