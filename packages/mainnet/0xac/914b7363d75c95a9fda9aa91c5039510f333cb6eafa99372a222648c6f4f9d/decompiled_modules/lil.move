module 0xac914b7363d75c95a9fda9aa91c5039510f333cb6eafa99372a222648c6f4f9d::lil {
    struct LIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIL>(arg0, 6, b"LIL", b"LIL PEPE FRUG", b"Discover the latest sensation in the meme token universe - Baby Pepe Token! Inspired by Matt Furie's adorable tweet showcasing a cuddly baby Pepe stuffed doll, Baby Pepe Token is here to bring a playful twist to your crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_06_23_10_b627dc307b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

