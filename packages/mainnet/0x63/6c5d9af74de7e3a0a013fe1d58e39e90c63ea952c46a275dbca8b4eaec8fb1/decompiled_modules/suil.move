module 0x636c5d9af74de7e3a0a013fe1d58e39e90c63ea952c46a275dbca8b4eaec8fb1::suil {
    struct SUIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIL>(arg0, 6, b"Suil", b"Dog of the SUI", x"2a626f726b2a202a626f726b2a0a0a57656c636f6d6520746f2074686520535549204f6365616e21204c6574206d652073686f7720796f752061726f756e6421200a0a5468697320746f6b656e20776173206372656174656420666f7220656e7465727461696e6d656e7420707572706f736573206f6e6c7920616e64206f6666657273206e6f2067756172616e746565206f662066696e616e6369616c2072657475726e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidog4_0d97830318.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

