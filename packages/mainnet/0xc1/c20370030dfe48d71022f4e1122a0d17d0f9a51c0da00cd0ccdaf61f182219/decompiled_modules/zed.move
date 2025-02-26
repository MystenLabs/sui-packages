module 0xc1c20370030dfe48d71022f4e1122a0d17d0f9a51c0da00cd0ccdaf61f182219::zed {
    struct ZED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZED>(arg0, 6, b"ZED", b"Zesdan", x"4dc3b469207472c6b0e1bb9d6e672073e1baa163682063686f206de1bb8d69207468e1bb9d6920c491e1baa169", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/9e5968a9-6254-4df3-9c59-7d91110176e2.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

