module 0xb42434f6392f78fa8f3648da2dbc5784561e98b1de84d2cf191ff88d5e92c0c6::wly {
    struct WLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLY>(arg0, 6, b"WLY", b"Waterly", b"Waterly is the memecoin that flows with creativity and freshness in the crypto world. Inspired by the art of watercolor, Waterly captures the essence of softness, vibrancy, and uniqueness, represented by its iconic girl with glasses in an artistic style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Waterly_a3044f0858.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

