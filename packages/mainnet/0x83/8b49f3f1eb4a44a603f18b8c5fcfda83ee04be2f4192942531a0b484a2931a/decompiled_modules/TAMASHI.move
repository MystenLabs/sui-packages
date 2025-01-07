module 0x838b49f3f1eb4a44a603f18b8c5fcfda83ee04be2f4192942531a0b484a2931a::TAMASHI {
    struct TAMASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMASHI>(arg0, 8, b"TAMASHI", b"Sui Tamashi", b"$TAMASHI, the first Genesis Chimper on Ape Express !CHIMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmP4LZZzT4iwo5M3YyFN7ZWZ5VnEJzfyiuJ69ammnxeieT?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMASHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TAMASHI>>(0x2::coin::mint<TAMASHI>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TAMASHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

