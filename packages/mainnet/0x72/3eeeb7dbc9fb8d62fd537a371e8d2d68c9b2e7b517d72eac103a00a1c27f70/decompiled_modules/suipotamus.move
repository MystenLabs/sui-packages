module 0x723eeeb7dbc9fb8d62fd537a371e8d2d68c9b2e7b517d72eac103a00a1c27f70::suipotamus {
    struct SUIPOTAMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOTAMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOTAMUS>(arg0, 6, b"Suipotamus", b"SUIpotamus", b"If Suipotamus reaches a 100M market cap, Ill tattoo Suipotamus on my face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wallet_hdr_eedb077b6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOTAMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOTAMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

