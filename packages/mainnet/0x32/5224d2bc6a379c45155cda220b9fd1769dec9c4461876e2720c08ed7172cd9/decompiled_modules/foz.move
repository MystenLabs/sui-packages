module 0x325224d2bc6a379c45155cda220b9fd1769dec9c4461876e2720c08ed7172cd9::foz {
    struct FOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOZ>(arg0, 6, b"FOZ", b"Fizh On Sui", x"f09f90a0204120667269656e646c7920666973682074686174206c6976657320696e2074686520405375694e6574776f726b2073656120f09f8c8a2024464f5a20416c77617973207361696c696e672c206e657665722073656c6c696e672120e29bb5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738560842182.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

