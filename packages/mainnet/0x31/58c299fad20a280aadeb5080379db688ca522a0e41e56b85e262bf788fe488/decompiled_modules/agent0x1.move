module 0x3158c299fad20a280aadeb5080379db688ca522a0e41e56b85e262bf788fe488::agent0x1 {
    struct AGENT0X1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT0X1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT0X1>(arg0, 6, b"Agent0X1", b"Agent 0X1", b"Meet Agent 0X1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000139551_8b12d22ee5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT0X1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT0X1>>(v1);
    }

    // decompiled from Move bytecode v6
}

