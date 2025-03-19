module 0x574d41467f2ca10d978b8711763889dfc6f238221d13b9d4fa539a18598ba09b::lan2 {
    struct LAN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN2>(arg0, 9, b"LAN2", b"LAN002", b"002", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.2008php.com//2019_Website_appreciate/2019-04-28/20190428132003s8SL6.gif"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN2>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN2>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN2>>(v2);
    }

    // decompiled from Move bytecode v6
}

