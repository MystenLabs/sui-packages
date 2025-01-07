module 0xb29d49b6b3d019f2a234ca177d75fce737be73a4db661b22090d5c5da938ffdf::dognald {
    struct DOGNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGNALD>(arg0, 6, b"DOGNALD", b"Dognald Trump Sui", b"Dognal trum on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002239_d87db907c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

