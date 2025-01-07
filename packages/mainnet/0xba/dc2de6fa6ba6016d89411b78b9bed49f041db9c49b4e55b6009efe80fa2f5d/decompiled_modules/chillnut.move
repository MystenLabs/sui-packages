module 0xbadc2de6fa6ba6016d89411b78b9bed49f041db9c49b4e55b6009efe80fa2f5d::chillnut {
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

