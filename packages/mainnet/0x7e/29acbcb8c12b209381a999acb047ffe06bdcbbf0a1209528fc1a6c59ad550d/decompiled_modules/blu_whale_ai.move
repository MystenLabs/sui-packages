module 0x7e29acbcb8c12b209381a999acb047ffe06bdcbbf0a1209528fc1a6c59ad550d::blu_whale_ai {
    struct BLU_WHALE_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU_WHALE_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU_WHALE_AI>(arg0, 9, b"BLUAI", b"Blu Whale AI", b"BLUAI Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775662722001-dbe8c1faa78c87fb239983a94a896792.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLU_WHALE_AI>>(0x2::coin::mint<BLU_WHALE_AI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLU_WHALE_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU_WHALE_AI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

