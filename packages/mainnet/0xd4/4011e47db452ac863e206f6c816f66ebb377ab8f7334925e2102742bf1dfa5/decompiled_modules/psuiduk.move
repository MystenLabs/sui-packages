module 0xd44011e47db452ac863e206f6c816f66ebb377ab8f7334925e2102742bf1dfa5::psuiduk {
    struct PSUIDUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIDUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIDUK>(arg0, 6, b"PSUIDUK", b"$PSUIDUK", b"This Psyduck-inspired memecoin is making waves on the Sui blockchain.   Join our community of headache-havers and gain-seekers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_psyduk_01_40d5f61fa2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIDUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIDUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

