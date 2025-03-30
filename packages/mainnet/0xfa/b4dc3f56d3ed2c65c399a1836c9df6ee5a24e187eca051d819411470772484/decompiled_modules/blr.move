module 0xfab4dc3f56d3ed2c65c399a1836c9df6ee5a24e187eca051d819411470772484::blr {
    struct BLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLR>(arg0, 9, b"BLr", b"Bull Run", b"Super percpective", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fbc99fe641b6c8dd0e6dec29268bfd45blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

