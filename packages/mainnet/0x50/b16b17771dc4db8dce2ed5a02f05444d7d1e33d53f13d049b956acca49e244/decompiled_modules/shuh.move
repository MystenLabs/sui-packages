module 0x50b16b17771dc4db8dce2ed5a02f05444d7d1e33d53f13d049b956acca49e244::shuh {
    struct SHUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUH>(arg0, 6, b"SHUH", b"SUIHUH", b"JUST HUH CAT IN SUI ECOSYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HUH_1be517c7ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

