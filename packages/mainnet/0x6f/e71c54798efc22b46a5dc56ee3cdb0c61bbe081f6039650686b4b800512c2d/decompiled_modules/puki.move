module 0x6fe71c54798efc22b46a5dc56ee3cdb0c61bbe081f6039650686b4b800512c2d::puki {
    struct PUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUKI>(arg0, 6, b"PUKI", b"Puki", x"4a7573742061206368696c6c2c206e61747572616c20636869636b2e204974e28099732063616c6c6564202450554b4920616e64206974206c6f766573206e61747572652c20657370656369616c6c79206c6f6e672074726565732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002509973.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

