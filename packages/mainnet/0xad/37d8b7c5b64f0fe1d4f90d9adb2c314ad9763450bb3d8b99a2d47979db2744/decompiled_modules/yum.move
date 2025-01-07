module 0xad37d8b7c5b64f0fe1d4f90d9adb2c314ad9763450bb3d8b99a2d47979db2744::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"SuiSauce", x"49747320746861742059756d2059756d205361756365206f6e205375690a54686520736175636520746861742065766572796f6e65206c6f766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2186_2c9907f158.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

