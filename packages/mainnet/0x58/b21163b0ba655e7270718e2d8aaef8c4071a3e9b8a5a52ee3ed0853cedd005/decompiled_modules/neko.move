module 0x58b21163b0ba655e7270718e2d8aaef8c4071a3e9b8a5a52ee3ed0853cedd005::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 9, b"NEKO", b"Neko Neko", b"Neko Neko Neko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiaydyuqcedyjv27j54snxguzov2m55rr5fqnonv5tsa4sfztdzcd4.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

