module 0x744418c5a4932258a1c36979b6765e4cc8e082470e4b165ca2e178ef8e7f6778::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"BABY PUG", x"426f726e2066726f6d20746865204f472c2046756420746865205075672c0a244250554720697320726561647920746f20737465616c207468650a73706f746c69676874206f6e20537569212020576974682069747320637574650a627574206d697363686965766f757320636861726d2c20426162790a507567206973206865726520746f206261726b206974732077617920746f0a74686520746f702c2077616767696e67207461696c7320616e640a77696e6e696e672068656172747320616c6f6e67207468652077617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731588364578.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

