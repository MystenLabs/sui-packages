module 0x60f5ccdf56911ea5aaf28afcd2046beaa6844498998f58be02abe49f8f9cf98b::popdog {
    struct POPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOG>(arg0, 6, b"POPDOG", b"Popdog", b"pop pop pop pop pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_b2d869b289.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

