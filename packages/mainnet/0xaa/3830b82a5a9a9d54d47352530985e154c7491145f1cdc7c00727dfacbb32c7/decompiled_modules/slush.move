module 0xaa3830b82a5a9a9d54d47352530985e154c7491145f1cdc7c00727dfacbb32c7::slush {
    struct SLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSH>(arg0, 6, b"Slush", b"Slush Token", b"Slush Wallet Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012084_31a72f8b16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

