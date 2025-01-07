module 0x2a4699ed7cde1ff7e4ce87260587cb72472fd693ba4c083818a719b10cb159b8::trumpio {
    struct TRUMPIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPIO>(arg0, 6, b"Trumpio", b"Trump Mario", b"A combo you never saw coming. Trump as Mario, ready to power up and take over Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_7d0f8cf819.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

