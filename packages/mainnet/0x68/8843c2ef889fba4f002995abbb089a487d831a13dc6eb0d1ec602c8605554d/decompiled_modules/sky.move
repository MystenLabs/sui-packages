module 0x688843c2ef889fba4f002995abbb089a487d831a13dc6eb0d1ec602c8605554d::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 9, b"SKY", b"Landscape", b"Sky, cloud, sun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7fb77bd-0dd7-4f8e-abbd-8735bbdc802a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

