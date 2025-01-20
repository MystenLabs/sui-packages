module 0x819f41e74fa1ee226daec2046f6887cc28f04b84597355e6ad46cb968623e696::pixie {
    struct PIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXIE>(arg0, 6, b"Pixie", b"Pixie AI", b"AI generator transforms your ideas into unique, high-quality visuals effortlessly. Create, customize, and download your artwork in just a few clicks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2134_7f3b508bb8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

