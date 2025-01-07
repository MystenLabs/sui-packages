module 0x38fcfb52a13bbdc9db7eea604a44452e0630b0a4573293d90d83bf0c991c8df0::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"Turbo Sui", b"Turbo came to Sui ready to take over sui in a big way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8812_9b6348232d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T>>(v1);
    }

    // decompiled from Move bytecode v6
}

