module 0x4d657b98a829385dc0ff5067ff09375e7c4f56600432da4d701fba7aa2fb56bf::cros {
    struct CROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROS>(arg0, 6, b"CROS", b"CROS SUI", b"CROS loves chilling with his bros BLUB, AAACAT and MEOW, but at some point they're doomed to become his next meal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_4_d3fa2c3299.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

