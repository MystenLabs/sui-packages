module 0xdf098516b0ecba9bc7db3e1c2d6b5aeb64c479170ed96808a6c60570885163f3::prts {
    struct PRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::none<0x2::url::Url>();
        let (v0, v1) = 0x2::coin::create_currency<PRTS>(arg0, 8, b"PRTS", b"Longmen_Coin", b"Currency issued by Longmen, with wide-ranging uses.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://patchwiki.biligame.com/images/arknights/thumb/0/0f/t5ygg18f380pcqvwt22rrplk11pv734.png/180px-%E9%BE%99%E9%97%A8%E5%B8%81.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

