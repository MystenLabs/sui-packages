module 0x5f5e4da968319f0e1816f3d23a12ad60a954517bf4c214c6b842dd47ad628a65::lupo {
    struct LUPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUPO>(arg0, 6, b"LUPO", b"Lupo", b"Lupo Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lupoooo_6fb705b0e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

