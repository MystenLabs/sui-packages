module 0x8344bd7e661fcf85b5deade8ab711cc1cc402927a07f11494ca50fc6f040a7c0::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 6, b"SD", b"SUIDENG", b"MOONDENG GOT TOUCHED BY SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9fb6745e_4d25_42fc_acb3_3068437f5796_52e5b42a0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SD>>(v1);
    }

    // decompiled from Move bytecode v6
}

