module 0x973d8870039cfb1cee432c04e4b00a17c300af60d3e55310eeb5dfc6aeae2781::megasui {
    struct MEGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGASUI>(arg0, 6, b"MEGASUI", b"First Mega on Sui", b"First Mega on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apple_touch_icon1_b2e316acd1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

