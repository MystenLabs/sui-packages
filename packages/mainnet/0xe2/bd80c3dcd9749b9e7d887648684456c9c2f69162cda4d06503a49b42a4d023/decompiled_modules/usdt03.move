module 0xe2bd80c3dcd9749b9e7d887648684456c9c2f69162cda4d06503a49b42a4d023::usdt03 {
    struct USDT03 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT03, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT03>(arg0, 9, b"USDT                         -", b"USDT                         -", b"USDT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/7hPDVYQd/BASE-USDT2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT03>>(0x2::coin::mint<USDT03>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT03>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT03>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

