module 0x154764588a55775619bbe2c026ee381578c0324cd41627aaaa3d04ebf3b87d09::fush {
    struct FUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSH>(arg0, 6, b"FUSH", b"Fush", b"Fush on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034381_57d601a36b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

