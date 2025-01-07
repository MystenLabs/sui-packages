module 0x4563fdbce1bca8541e26c11a4a278cefc2008ff3e8d5fb386d7c33175da72574::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 9, b"GEM", b"GEMTOKEN", b"Build BLACK GEM Memecoin, an amazing and complex digital currency inspired by the allure of rare black gemstones", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d99a530-baf6-4360-9aff-c775c6f976c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

