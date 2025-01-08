module 0x5dce91f0f3bab2daa0523e437fe6618d8a5594fa6142470411c9e164b0ef5b5b::sxb {
    struct SXB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SXB>(arg0, 6, b"SXB", b"SUiXbt by SuiAI", b"From AI to degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/A_Ie9_T5v4_400x400_22eda92baf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SXB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

