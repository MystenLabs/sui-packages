module 0xb58b018e22b0e1f6e9e49e62461d328e72095d4037c3f9a1de14c005db6815e6::lie5 {
    struct LIE5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIE5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIE5>(arg0, 6, b"LIE5", b"LIE$", b"LIFE IS EXPENSIVE,THE 5 IS SERIOUSLY A S,FILL YOUR POCKETS WITH LIE5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_19becea385.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIE5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIE5>>(v1);
    }

    // decompiled from Move bytecode v6
}

