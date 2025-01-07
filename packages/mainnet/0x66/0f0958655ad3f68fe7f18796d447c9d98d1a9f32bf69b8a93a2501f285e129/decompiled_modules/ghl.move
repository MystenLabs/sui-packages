module 0x660f0958655ad3f68fe7f18796d447c9d98d1a9f32bf69b8a93a2501f285e129::ghl {
    struct GHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHL>(arg0, 6, b"GHL", b"GHOUL", b"ghoul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ken_Kaneki_a217a600c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

