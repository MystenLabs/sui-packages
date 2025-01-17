module 0xe5395f84df4fd3de68e9c39d7d0ff65e2059c6309e4c20764b7514938d5389ff::dif {
    struct DIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIF>(arg0, 6, b"DIF", b"DevIsFish", b"Dev is literally fish. Community token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1418_20536c561f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

