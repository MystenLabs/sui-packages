module 0xa613dcbd506ac7c0f5fd5574e26eaa53c2279bfcbae7e4541af98d697ef9a786::paxg {
    struct PAXG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAXG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAXG>(arg0, 8, b"PAXG", b"PAX Gold", b"ZO Virtual Coin for PAX Gold", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAXG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAXG>>(v0);
    }

    // decompiled from Move bytecode v6
}

