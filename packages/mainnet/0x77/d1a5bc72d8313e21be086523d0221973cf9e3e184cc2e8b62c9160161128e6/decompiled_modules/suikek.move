module 0x77d1a5bc72d8313e21be086523d0221973cf9e3e184cc2e8b62c9160161128e6::suikek {
    struct SUIKEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEK>(arg0, 6, b"SUIKEK", b"SUIKEK MAXIMUS", b"They did it for ETH and SOL, we did it for SUI - or maybe something even bigger. Elon hasn't tweeted about it yet but don't worry, SUIKEK is working on sending him a cake. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01f66587_23bc_4453_a9cf_058ca8c4e525_1fba29b10c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

