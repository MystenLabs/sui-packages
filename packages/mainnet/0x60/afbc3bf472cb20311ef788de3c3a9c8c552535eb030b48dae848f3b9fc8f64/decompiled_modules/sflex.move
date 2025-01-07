module 0x60afbc3bf472cb20311ef788de3c3a9c8c552535eb030b48dae848f3b9fc8f64::sflex {
    struct SFLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLEX>(arg0, 6, b"Sflex", b"SUUflex", b"sfsfsfwsfwsfwsfwxsfwxsfwxxsfwxxsfwxxxsfwxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3046_8a0ee4ae7d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

