module 0xdb7f5e181b35dff45f2ce26a0532e3c67edf3b5f5eca3e5664f4c451a49a340e::chillnut {
    struct CHILLNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLNUT>(arg0, 6, b"CHILLNUT", b"CHILLPNUT", b"CHILL PNUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillguy_1_g_ID_7_a7446ee80a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

