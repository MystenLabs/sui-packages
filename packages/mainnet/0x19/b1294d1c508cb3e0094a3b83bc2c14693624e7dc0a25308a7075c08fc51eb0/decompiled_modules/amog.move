module 0x19b1294d1c508cb3e0094a3b83bc2c14693624e7dc0a25308a7075c08fc51eb0::amog {
    struct AMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMOG>(arg0, 6, b"AMOG", b"Alpha Man Of The Group", b"$AMOG, derived from the term \"mogged\" refers to the \"Alpha Man of the Group\" who consistently outclasses others in social, physical, or status-based situations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051016_cc33581f36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

