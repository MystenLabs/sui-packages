module 0xee8aa8bc7b893e24005c44b1db053676e7029dc3d9d21696e9f1797cd9dcef4e::wtfduck {
    struct WTFDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFDUCK>(arg0, 6, b"WTFDUCK", b"WTF Duck", b"wtfduck.fun . More socials to come shortly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_175551_b941a2d693.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTFDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

