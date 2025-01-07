module 0xdb7f34dfed12220916b62befbc56df7fde7c10f891e7c2f9a4e2bc15b3492b12::paper {
    struct PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPER>(arg0, 6, b"Paper", b"Paper Hands CTO", b"CTO for those who was hurt by Paper hands and  jeeters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_08_190157_e3c0243269.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

