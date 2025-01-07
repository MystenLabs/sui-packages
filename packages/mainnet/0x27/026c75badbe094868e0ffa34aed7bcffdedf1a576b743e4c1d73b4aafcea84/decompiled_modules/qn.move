module 0x27026c75badbe094868e0ffa34aed7bcffdedf1a576b743e4c1d73b4aafcea84::qn {
    struct QN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QN>(arg0, 6, b"QN", b"QNN", x"53555045522044555045522048494e455920534e4946464552200a0a456c6f6e73206c617374657374207477656574207368696c6c696e672063727970746f212120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731883611671.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

