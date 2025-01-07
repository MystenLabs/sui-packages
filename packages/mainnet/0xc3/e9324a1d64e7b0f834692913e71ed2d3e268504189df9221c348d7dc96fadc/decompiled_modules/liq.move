module 0xc3e9324a1d64e7b0f834692913e71ed2d3e268504189df9221c348d7dc96fadc::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 6, b"LIQ", b"Liquor", b"Be liquor, my friend. New era of meme on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_H_E2_Fq_E_400x400_607e3ab626.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

