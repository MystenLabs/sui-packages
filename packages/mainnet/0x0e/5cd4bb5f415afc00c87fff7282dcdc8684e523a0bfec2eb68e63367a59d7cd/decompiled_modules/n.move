module 0xe5cd4bb5f415afc00c87fff7282dcdc8684e523a0bfec2eb68e63367a59d7cd::n {
    struct N has drop {
        dummy_field: bool,
    }

    fun init(arg0: N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N>(arg0, 9, b"N", b"nioCoin", b"Governance token for the nioCoin ecosystem. First token on nioCoin factory. 0-fee DLMM pool.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<N>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

