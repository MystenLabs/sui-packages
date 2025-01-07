module 0x4418c1284b7d95a2585648d65a048310d627e6cc7a6f8ab331b14acc72e6b70f::ew {
    struct EW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EW>(arg0, 6, b"EW", b"Ewwwww", b"Has been and all will be a MEME. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000294240_e892072307.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EW>>(v1);
    }

    // decompiled from Move bytecode v6
}

