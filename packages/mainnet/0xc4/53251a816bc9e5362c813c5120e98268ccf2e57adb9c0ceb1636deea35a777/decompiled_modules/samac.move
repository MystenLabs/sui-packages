module 0xc453251a816bc9e5362c813c5120e98268ccf2e57adb9c0ceb1636deea35a777::samac {
    struct SAMAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMAC>(arg0, 9, b"SAMAC", b"SAMAC", b"9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/ohozTqPpj3rS2GmR9wGQK821whaXMuWzEVL_bbByc5U")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMAC>>(0x2::coin::mint<SAMAC>(&mut v2, 9000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAMAC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMAC>>(v1);
    }

    // decompiled from Move bytecode v7
}

