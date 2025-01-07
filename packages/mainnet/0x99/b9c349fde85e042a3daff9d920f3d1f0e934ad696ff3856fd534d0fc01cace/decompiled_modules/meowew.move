module 0x99b9c349fde85e042a3daff9d920f3d1f0e934ad696ff3856fd534d0fc01cace::meowew {
    struct MEOWEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWEW>(arg0, 6, b"MEOWEW", b"Meowecoin", b"making CryptoCat not just a protector, but a symbol of hope in the cyber realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055791_5fbfc7230a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

