module 0xad4f276645776fe50fa911c523e42941705c406313984db4320ef18321463f4a::bolt {
    struct BOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLT>(arg0, 6, b"BOLT", b"BOLT SUI FUN", b"man's best friend on sui.Check now: https://www.boltonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_3_29bdbf20bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

