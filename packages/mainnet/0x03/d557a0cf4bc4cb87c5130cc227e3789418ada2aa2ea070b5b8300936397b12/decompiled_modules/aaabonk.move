module 0x3d557a0cf4bc4cb87c5130cc227e3789418ada2aa2ea070b5b8300936397b12::aaabonk {
    struct AAABONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABONK>(arg0, 6, b"AaaBonk", b"AaaaBONK", b"Aaaaaaaaaaaaa.... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016661_50f4895934.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

