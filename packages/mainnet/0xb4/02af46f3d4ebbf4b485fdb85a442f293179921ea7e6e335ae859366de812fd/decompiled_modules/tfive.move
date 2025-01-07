module 0xb402af46f3d4ebbf4b485fdb85a442f293179921ea7e6e335ae859366de812fd::tfive {
    struct TFIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFIVE>(arg0, 6, b"TFIVE", b"TwentyFive", x"486579204164656e6979692c207768617427732066756e6e696572207468616e2032343f200a0a3235", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735661090875.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

