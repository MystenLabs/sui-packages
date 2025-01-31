module 0x51f1dbb02352a1495dc655b2e1c722b859147881ebb7854375bcc054f4f38d38::columbus {
    struct COLUMBUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLUMBUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLUMBUS>(arg0, 6, b"Columbus", b"Columbus Sui", x"22576f772c204920646973636f766572656420746865204e657720576f726c642c2049276d20436f6c756d62757322202d205375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738307331947.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLUMBUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLUMBUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

