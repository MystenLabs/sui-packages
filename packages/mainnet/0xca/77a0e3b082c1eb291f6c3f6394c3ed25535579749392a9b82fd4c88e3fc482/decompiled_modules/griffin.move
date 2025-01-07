module 0xca77a0e3b082c1eb291f6c3f6394c3ed25535579749392a9b82fd4c88e3fc482::griffin {
    struct GRIFFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIFFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIFFIN>(arg0, 6, b"Griffin", b"Sui Griffin", b"Its Peter Griffin... but on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Griffin_7858724e11.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIFFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIFFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

