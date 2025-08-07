module 0xf8c0661e793d45c3ccb65ffd2b6023621d19153ee891e2d462b305c696fa520c::shitsui {
    struct SHITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITSUI>(arg0, 6, b"ShitSui", b"Shit Sui", b"Shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidz6dpzaobcttzndxhaow64mx6hw4x4k2df2ef6siaerwcwqjjxpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHITSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

