module 0xfc7dc8b453b5d4e68625dcbb529595762b94974e490fbda9d7cb5559ca1f62ce::suilah {
    struct SUILAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAH>(arg0, 6, b"SUILAH", b"Sui Lah Cat", x"e2809c5355494c4148e2809d2069732061206d616e74726120666f7220706f73697469766974792c20676f6f642076696265732c20616e6420676f6f64206c75636b2e0a0a5468697320746f6b656e2069736ee2809974206865726520746f2074656c6c20796f7520746f206275792e0a4974e2809973206865726520746f2072656d696e6420796f753a0a0a53746179206b696e642e2053707265616420706f73697469766520656e657267792e0a476f6f64206c75636b2077696c6c2066696e64206974732077617920746f20796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789544802391.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

