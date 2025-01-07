module 0x4efd13d41cb98cf5c15ebfb52a23ac7898d8b659d8ac91562415a8cd304a31d1::raindog {
    struct RAINDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINDOG>(arg0, 6, b"RAINDOG", b"Raindog on sui", b"Soon launching SUI gamble play, dev past project hit 1.6M, nice ticker and branding, dyor if going in. Raindog crypto, capturing the essence of peace with its adorable dog this token fosters a community driven approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241218_102019_331_9c8c6a8428.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAINDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

