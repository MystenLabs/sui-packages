module 0xe483ff68c168d36bd515aad772feac5ae8fb16f0a57e3933fda0824b25b9c996::rato {
    struct RATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATO>(arg0, 6, b"Rato", b"Rato The Rat", b"Rato the Rat. The newest Matt Furie character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_a_8c530d9061.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

