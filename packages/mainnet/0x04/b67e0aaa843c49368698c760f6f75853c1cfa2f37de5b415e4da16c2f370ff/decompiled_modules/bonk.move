module 0x4b67e0aaa843c49368698c760f6f75853c1cfa2f37de5b415e4da16c2f370ff::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"BONK", b"BONK IN THE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/23095.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BONK>(&mut v2, 6900000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

