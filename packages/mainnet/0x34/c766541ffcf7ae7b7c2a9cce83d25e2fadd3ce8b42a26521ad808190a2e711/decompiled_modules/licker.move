module 0x34c766541ffcf7ae7b7c2a9cce83d25e2fadd3ce8b42a26521ad808190a2e711::licker {
    struct LICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICKER>(arg0, 6, b"LICKER", b"SCUM LICKER", b"Licker - the most disgusting and degenerate form of shitcoin addiction. A bottom feeder in the cesspool of crypto. Hell do just about anything for an ECA or some alpha on the next 100x.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241009_220731_401_0e3f828edd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

