module 0x15cd082085806677952ad8ffae9c7411aa7c07759b5ca81000e0fc1967429388::lpf {
    struct LPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPF>(arg0, 6, b"LPF", b"LIL PEPE FRUG", b"Discover the latest sensation in the meme token universe - Baby Pepe Token! Inspired by Matt Furie's adorable tweet showcasing a cuddly baby Pepe stuffed doll, Baby Pepe Token is here to bring a playful twist to your crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_19_45_31_e9fa3f3966.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

