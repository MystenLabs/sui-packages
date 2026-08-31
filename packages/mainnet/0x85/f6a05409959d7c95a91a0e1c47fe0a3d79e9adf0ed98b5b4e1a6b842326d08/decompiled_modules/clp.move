module 0x85f6a05409959d7c95a91a0e1c47fe0a3d79e9adf0ed98b5b4e1a6b842326d08::clp {
    struct CLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLP>(arg0, 6, b"CLP", b"Crypto LP", b"Represent a share of CLP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

