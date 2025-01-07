module 0x36535387d1220f4038fe48c866fcf2927193c8bbd6e484fe0a25cec648c5a7e6::kds {
    struct KDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDS>(arg0, 6, b"KDS", b"KatDoog on SUI", b"The Ultimate Dog & Cat Memecoin Narrative!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rrmn_TN_Qi_400x400_2dbc5f3612.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

