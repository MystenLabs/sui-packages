module 0xb064bae39159298624654ad56a146b2d67595518f8e65a1b28c5fdadbbb18a76::cetuscto {
    struct CETUSCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUSCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSCTO>(arg0, 6, b"CETUSCTO", b"Cetus CTO ", x"466c617368204372617368206861636b20676f7420757320616c6c206665656c696e67205375692d436964616c0a0a43544f2043544f2043544f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747933047937.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSCTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSCTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

