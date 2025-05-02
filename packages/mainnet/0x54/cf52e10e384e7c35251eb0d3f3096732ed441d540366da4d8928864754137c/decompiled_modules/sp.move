module 0x54cf52e10e384e7c35251eb0d3f3096732ed441d540366da4d8928864754137c::sp {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 6, b"SP", b"SUIPEE", b"Spotted at the Sui blockchain meet and greet in Dubai Token 2049", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746156790087.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

