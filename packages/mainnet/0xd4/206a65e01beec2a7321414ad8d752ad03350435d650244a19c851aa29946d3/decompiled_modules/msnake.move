module 0xd4206a65e01beec2a7321414ad8d752ad03350435d650244a19c851aa29946d3::msnake {
    struct MSNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSNAKE>(arg0, 6, b"MSNAKE", b"Mystery Snake", b"Mystery", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/removal_ai_ad94299c_eec5_4de5_aff6_a0063686d7b1_logo_df5515bc06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

