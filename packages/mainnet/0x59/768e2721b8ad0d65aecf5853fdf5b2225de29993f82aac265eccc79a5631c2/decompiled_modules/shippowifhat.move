module 0x59768e2721b8ad0d65aecf5853fdf5b2225de29993f82aac265eccc79a5631c2::shippowifhat {
    struct SHIPPOWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIPPOWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIPPOWIFHAT>(arg0, 6, b"SHIPPOWIFHAT", b"SHippoWifHat Meme", b"While not formally recognized, symbolizes HIPPOWIFHAT, the mascot of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_at_1_36_26a_pm_219230039d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIPPOWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIPPOWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

