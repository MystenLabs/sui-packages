module 0x57dc4e13aa41f359ab49d41d93e021b75f033056bef0ebf78c23450c2fd3f40b::suistreet {
    struct SUISTREET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTREET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTREET>(arg0, 6, b"SUISTREET", b"WOLFIUS MAXIMUS OF SUISTREET", b"Wolfius Maximus is all about the power and instincts of Suistreets strongest wolves. Its not just a meme coinits for those who are smart, strong, and ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logosuistreet_9a3e315a01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTREET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTREET>>(v1);
    }

    // decompiled from Move bytecode v6
}

