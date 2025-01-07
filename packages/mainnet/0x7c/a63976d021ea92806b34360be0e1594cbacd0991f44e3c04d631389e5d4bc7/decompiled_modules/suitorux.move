module 0x7ca63976d021ea92806b34360be0e1594cbacd0991f44e3c04d631389e5d4bc7::suitorux {
    struct SUITORUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORUX>(arg0, 6, b"SuitoruX", b"Techno", x"546865206c6567656e64617279206d656368616e6963616c204d6173636f74206f6620537569436861696e2e0a4e616d653a20537569746f7275200a4d6f64656c3a2058", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014350_92545af743.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITORUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITORUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

