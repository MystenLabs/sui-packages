module 0xaefdd403e0b79d2164c9c47103f84c986f6c9ff9958d48ac64291f2a55e4b724::blank {
    struct BLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLANK>(arg0, 6, b"BLANK", b"SUI BLANK PAGE", b"blank coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLANK_0626188f69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

