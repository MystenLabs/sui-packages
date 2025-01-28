module 0x7b70448f1797f9447dd2e7fc33d0b834df6581c55cbaab9e5bcff7f6416292fd::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 6, b"DOLLAR", b"1 DOLLAR REAL", b"The $1 coin is driven by a strong, united community with a bold mission: to offset inflation, achieve, and surpass a $1 value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gg_H_Ypcp_WYAAP_DF_0a4a4d1fe3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

