module 0x2ead89187af183d47a06e3eced2d5355df455fbf5111bd3f4dc7d6f33be10922::tooty {
    struct TOOTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOTY>(arg0, 6, b"TOOTY", b"TOOTY GINT CHICK", x"546f6f74792069732061206769616e7420636869636b20210a58203a2068747470733a2f2f782e636f6d2f544f4f54595355490a54454c454752414d3a2068747470733a2f2f742e6d652f2b4749786566526e5762346b7759324939", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_014238_fc1cf41b5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

