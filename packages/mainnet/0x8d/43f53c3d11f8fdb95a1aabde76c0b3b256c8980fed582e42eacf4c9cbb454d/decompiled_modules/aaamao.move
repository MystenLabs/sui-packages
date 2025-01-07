module 0x8d43f53c3d11f8fdb95a1aabde76c0b3b256c8980fed582e42eacf4c9cbb454d::aaamao {
    struct AAAMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMAO>(arg0, 6, b"AAAMAO", b"aaa mao", b"aaa cat chinese version (aaaMao),Can't stop, won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6763_35e1bb4757.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

