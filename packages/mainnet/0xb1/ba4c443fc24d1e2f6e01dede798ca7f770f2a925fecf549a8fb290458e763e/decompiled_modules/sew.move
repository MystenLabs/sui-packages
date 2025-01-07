module 0xb1ba4c443fc24d1e2f6e01dede798ca7f770f2a925fecf549a8fb290458e763e::sew {
    struct SEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEW>(arg0, 6, b"SEW", b"cat in a sui world", b"It's the dawn of a new era...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020252_7491ec0d07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

