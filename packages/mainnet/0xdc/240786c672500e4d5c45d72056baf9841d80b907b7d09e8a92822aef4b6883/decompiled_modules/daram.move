module 0xdc240786c672500e4d5c45d72056baf9841d80b907b7d09e8a92822aef4b6883::daram {
    struct DARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARAM>(arg0, 6, b"DARAM", b"DARAM ON SUI", b"The author of this goose is my three-year-old daughter.Dexscreener paid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_28_990e2fb180.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

