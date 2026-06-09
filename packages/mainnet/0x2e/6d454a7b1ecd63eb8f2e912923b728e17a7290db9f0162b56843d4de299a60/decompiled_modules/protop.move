module 0x2e6d454a7b1ecd63eb8f2e912923b728e17a7290db9f0162b56843d4de299a60::protop {
    struct PROTOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROTOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOP>(arg0, 6, b"PROTOP", b"ProtoPecuni", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROTOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROTOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

