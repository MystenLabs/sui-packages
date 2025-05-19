module 0xf6ca6c236fbab05499d60899d382cf749d31aee98bdbcebeafdb92def2121c6f::mevai {
    struct MEVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEVAI>(arg0, 6, b"MEVAI", b"Hybrid Mev", b"We envision a future where AI agents operate autonomously on the blockchain, executing complex tasks MULTHICHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhiy27aowsdzpzyfv5io37snjwrz5uitnvcr4gmoggvstgeljljm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEVAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEVAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

