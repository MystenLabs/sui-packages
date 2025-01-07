module 0x7487679be077ce9bdf37912bb5a0a3ef1e397fe142a7dea08054f3422a553322::suishu {
    struct SUISHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHU>(arg0, 6, b"Suishu", b"Crazy OG Cat Suishu", x"0a57652068617665206865726520746865206d6f7374206163746976652063617420696e205355492c206865206973206879706572206163746976652c206865206c6f76657320746f2064616e63652c20686520697320616c7761797320696e206120676f6f64206d6f6f642c206865206973206865726520746f20737461792e0a5468652066756e6e696573742063617420696e207468652065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731483052846.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

