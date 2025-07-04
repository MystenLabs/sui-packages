module 0xb432a40bd9b0f6ce052c11098c5fb4f9e94130211e90810c105a8c1e48757cc3::usdt_test {
    struct USDT_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_TEST>(arg0, 6, b"USDT-TEST", b"USDT-TEST", b"Tether USD Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/USDT-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

