module 0x6cafe34c79a18cbd4dafa691d3039fc06ae6cde888ef29da06a90cde2cf4aef8::lusy {
    struct LUSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSY>(arg0, 6, b"LUSY", b"Sui LusyDog", b"$LUSY The original DOG-themed meme coin on the Sui blockchain! As the first of its kind,  When it comes to DOG coins on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001080_91223373d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

