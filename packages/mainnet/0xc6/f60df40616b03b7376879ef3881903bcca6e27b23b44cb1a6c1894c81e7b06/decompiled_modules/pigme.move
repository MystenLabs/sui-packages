module 0xc6f60df40616b03b7376879ef3881903bcca6e27b23b44cb1a6c1894c81e7b06::pigme {
    struct PIGME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGME>(arg0, 6, b"PigMe", b"Pig On Sui", b"Pig Ocean Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipig_a839c6ba4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGME>>(v1);
    }

    // decompiled from Move bytecode v6
}

