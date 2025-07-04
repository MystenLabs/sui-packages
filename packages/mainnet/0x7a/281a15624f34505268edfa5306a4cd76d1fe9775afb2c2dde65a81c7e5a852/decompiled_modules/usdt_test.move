module 0x7a281a15624f34505268edfa5306a4cd76d1fe9775afb2c2dde65a81c7e5a852::usdt_test {
    struct USDT_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_TEST>(arg0, 6, b"USDT-TEST", b"USDC Test", b"USDC Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/USDT-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

