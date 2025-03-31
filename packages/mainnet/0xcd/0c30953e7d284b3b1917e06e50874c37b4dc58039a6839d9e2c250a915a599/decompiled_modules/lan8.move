module 0xcd0c30953e7d284b3b1917e06e50874c37b4dc58039a6839d9e2c250a915a599::lan8 {
    struct LAN8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN8>(arg0, 9, b"LAN8", b"LAN008", b"008", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.qlnote.com/static/upload/IMG_E7921.JPG"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN8>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN8>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN8>>(v2);
    }

    // decompiled from Move bytecode v6
}

