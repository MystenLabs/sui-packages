module 0x6206d8d6e61d910922731e36a1d804791305789acbafed9ee8f7748dd4231ef2::gvlin {
    struct GVLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVLIN>(arg0, 6, b"GVLIN", b"Geeked vs. Locked In", b"Are you geeked or locked in?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6756_1_0421f9815d.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GVLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

