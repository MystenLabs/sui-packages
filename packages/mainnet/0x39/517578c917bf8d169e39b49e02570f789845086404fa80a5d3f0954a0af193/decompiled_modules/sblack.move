module 0x39517578c917bf8d169e39b49e02570f789845086404fa80a5d3f0954a0af193::sblack {
    struct SBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLACK>(arg0, 6, b"SBLACK", b"Shiblack", b"New black meta dog on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DFFC_29_C4_CA_03_444_B_B852_5_F9550831790_d9bece2fcd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

