module 0xd1b4d4763ca0cd1358caf3b880e4423deec3068f361a2c81f3be8cd8334f69a5::maxbuytest {
    struct MAXBUYTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXBUYTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXBUYTEST>(arg0, 9, b"MBT", b"maxbuytest", b"just a max buy test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3668e19c-83fc-45a3-af8a-2aa238829bdc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXBUYTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXBUYTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

