module 0xfb44c5b3edf76d5acd7c108b834c12247ce632d339bac82c1e1f760e4d2ccdc9::wynn {
    struct WYNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 6, b"WYNN", b"ANITA MAX WYNN", b"Ladies with gentle hands this is my alter ego. $WYNN on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_T_Pl_m_S4_400x400_ba6bfac665.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

