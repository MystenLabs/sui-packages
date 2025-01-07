module 0xdf03935e45a2397f5e328afb74ecf693e240b107cdb2ff501d275a77df36d311::gue {
    struct GUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUE>(arg0, 6, b"GUE", b"GGULEe", b"She is escape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0711_38c586d0cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

