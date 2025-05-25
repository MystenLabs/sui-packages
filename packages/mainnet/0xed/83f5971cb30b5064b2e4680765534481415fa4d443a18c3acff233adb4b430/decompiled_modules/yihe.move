module 0xed83f5971cb30b5064b2e4680765534481415fa4d443a18c3acff233adb4b430::yihe {
    struct YIHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIHE>(arg0, 6, b"YIHE", b"YiHe on Sui", b"Co-Founder & Chief customer service officer Binance on Sui MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001472_1cce648211.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

