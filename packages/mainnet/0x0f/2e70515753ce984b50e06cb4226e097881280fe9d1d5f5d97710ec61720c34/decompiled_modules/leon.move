module 0xf2e70515753ce984b50e06cb4226e097881280fe9d1d5f5d97710ec61720c34::leon {
    struct LEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEON>(arg0, 6, b"LEON", b"Suirtleon", b"Hey there, fellow memers! Have you ever wanted your own super-cool digital pet? Well, Suirtleon is here to make your dreams come true! We have AI-project coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirtleon_27e25ecc77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

