module 0x439cc3df79e3b8b52919b1189ad61e168585aaedc3b06941238b3de8fbd2c852::memehub {
    struct MEMEHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEHUB>(arg0, 6, b"MEMEHUB", b"MEME HUB SUI", b"MEME HUB ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_55fb32caeb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

