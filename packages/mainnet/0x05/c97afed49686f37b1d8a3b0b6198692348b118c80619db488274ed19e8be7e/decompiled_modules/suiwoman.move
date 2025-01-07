module 0x5c97afed49686f37b1d8a3b0b6198692348b118c80619db488274ed19e8be7e::suiwoman {
    struct SUIWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMAN>(arg0, 6, b"SUIWOMAN", b"Suiwoman", b"The woman with sui powers on her way to save the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_06_T212418_615_5e75174702.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

