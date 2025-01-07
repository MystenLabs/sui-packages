module 0x76f27d5cf9f6881ce61b7a345fc7db3b09f01a4554212d0c85ac3097a4b9c36b::cherry {
    struct CHERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERRY>(arg0, 6, b"CHERRY", b"The Cherry", b"This is Cherry's world and your just living in it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_dc6d2c796f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

