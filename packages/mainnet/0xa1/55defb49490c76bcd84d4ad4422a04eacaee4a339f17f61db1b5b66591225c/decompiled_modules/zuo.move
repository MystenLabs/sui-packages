module 0xa155defb49490c76bcd84d4ad4422a04eacaee4a339f17f61db1b5b66591225c::zuo {
    struct ZUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUO>(arg0, 6, b"ZUO", b"Zuo", x"5a756f206973206120637574652c20736d61727420646f672c2068617320657870657269656e636520616e64207374726f6e672068756e74696e6720706f7765722c2062757420626568696e642074686174206865206973206120676f6f642c206f62656469656e7420646f672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053468_819e230377.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

