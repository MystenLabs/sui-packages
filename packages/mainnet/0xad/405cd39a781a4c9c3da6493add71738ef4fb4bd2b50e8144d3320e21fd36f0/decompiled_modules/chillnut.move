module 0xad405cd39a781a4c9c3da6493add71738ef4fb4bd2b50e8144d3320e21fd36f0::chillnut {
    struct CHILLNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLNUT>(arg0, 6, b"CHILLNUT", b"CHILLPNUT", b"CHILL PNUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillguy_1_g_ID_7_e599567c72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

