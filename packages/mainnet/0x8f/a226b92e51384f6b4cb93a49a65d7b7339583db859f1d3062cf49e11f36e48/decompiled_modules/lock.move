module 0x8fa226b92e51384f6b4cb93a49a65d7b7339583db859f1d3062cf49e11f36e48::lock {
    struct LOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCK>(arg0, 6, b"LOCK", b"Lock", b"Just Lock, When to lock, Lock Lock Lock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057667_43975b1125.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

