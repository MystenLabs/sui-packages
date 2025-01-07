module 0x4d34b0412080477fd8bdddae9a08bddca00812537fabbb4ffe34672d8fe124eb::psuiduck {
    struct PSUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUIDUCK>(arg0, 6, b"PSUIDUCK", b"pSuiduck", b"This Psyduck-inspired memecoin is making waves on the Sui blockchain. Join our community of headache-havers and gain-seekers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_psyduk_01_40d5f61fa2_712495b07e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

