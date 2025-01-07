module 0x263c156ff36026d1a18ee05e2403beb4c34fe3e358be59b7a41db86e8311ed5d::pepegold {
    struct PEPEGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGOLD>(arg0, 6, b"PEPEGOLD", b"SUI PEPEGOLD", b"THE GOLD STANDARD | MAKE #SOLANA GREAT AGAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_QER_Wws_B_400x400_c75bab3c33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

