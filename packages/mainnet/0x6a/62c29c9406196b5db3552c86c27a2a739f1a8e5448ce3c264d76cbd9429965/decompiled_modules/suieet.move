module 0x6a62c29c9406196b5db3552c86c27a2a739f1a8e5448ce3c264d76cbd9429965::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"SUIEET", b"Suieet", b"The Sweetest Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_C6n_L3m_400x400_dd940ab23f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

