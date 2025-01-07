module 0x6d305631063a03b937f26897f4dcd150df8346a140a7b75419f26d0fbadae3bd::starzy {
    struct STARZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARZY>(arg0, 6, b"STARZY", b"Starzy", b"Hands up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/starzy_432445fa33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

