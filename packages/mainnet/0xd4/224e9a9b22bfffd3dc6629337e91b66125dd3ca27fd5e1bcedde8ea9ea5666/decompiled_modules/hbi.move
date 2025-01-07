module 0xd4224e9a9b22bfffd3dc6629337e91b66125dd3ca27fd5e1bcedde8ea9ea5666::hbi {
    struct HBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBI>(arg0, 6, b"hbi", b"ozug", b"fdv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HBI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

