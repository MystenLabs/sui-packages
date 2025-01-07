module 0xc01991f8e912963d9462cef4f4e5769ad20505303963c72f04b73a09e794b3a7::llha {
    struct LLHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLHA>(arg0, 6, b"LLHA", b"Lamala HarriSUI", b"Lamala jeeted Biden out of his office to gain power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241201_124304_2_0bef02f50e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

