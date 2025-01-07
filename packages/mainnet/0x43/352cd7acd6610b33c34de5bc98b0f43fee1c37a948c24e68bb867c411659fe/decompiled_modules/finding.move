module 0x43352cd7acd6610b33c34de5bc98b0f43fee1c37a948c24e68bb867c411659fe::finding {
    struct FINDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINDING>(arg0, 6, b"FINDING", b"FINDING SUI", x"46494e44494e4720535549200a4255592042555920425559", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd7c00d25b550d2c196cbac3c32b280bd89f00bcd699b0ba4201a211be623cb8f_suimo_suimo_ece8d5d87c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINDING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINDING>>(v1);
    }

    // decompiled from Move bytecode v6
}

