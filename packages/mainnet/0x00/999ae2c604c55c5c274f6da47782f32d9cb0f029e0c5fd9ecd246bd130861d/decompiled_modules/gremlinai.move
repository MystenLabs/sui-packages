module 0x999ae2c604c55c5c274f6da47782f32d9cb0f029e0c5fd9ecd246bd130861d::gremlinai {
    struct GREMLINAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREMLINAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREMLINAI>(arg0, 6, b"GREMLINAI", b"GREMLINAI", b"Glitch Gremlin AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-Bx6XZrN7pjbDA5wkiKagbbyHSr1jai45m8peSSmJpump-98.png/type=default_350_0?v=1736198160268&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREMLINAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GREMLINAI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREMLINAI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

