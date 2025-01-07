module 0x9073314302c6aed9266c6ef364bffa8de922749c2da15decd56e1bf23e4beed1::aia {
    struct AIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIA>(arg0, 6, b"AiA", b"Ai Agents Sui", x"4169204167656e747320436f696e20244169410a0a68747470733a2f2f742e6d652f61696167656e7473636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_182302_399_2b5ee7386b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

