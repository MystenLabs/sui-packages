module 0xf3c036bbccaa11a9c88b24eef3d5a118ba72cba0f2cc4fc2b42d8c59b144775f::books {
    struct BOOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKS>(arg0, 6, b"BOOKS", b"DeepBook Protocol On Sui", b"The premier decentralized liquidity layer for builders, traders, and the broader DeFi community, exclusively on @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_45699d964b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

