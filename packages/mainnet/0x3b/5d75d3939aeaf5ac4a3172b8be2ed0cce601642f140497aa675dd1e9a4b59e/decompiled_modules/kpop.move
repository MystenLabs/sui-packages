module 0x3b5d75d3939aeaf5ac4a3172b8be2ed0cce601642f140497aa675dd1e9a4b59e::kpop {
    struct KPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<KPOP>(arg0, 6, 0x1::string::utf8(b"KPOP"), 0x1::string::utf8(b"K-POP"), 0x1::string::utf8(b"Where K-POP culture meets internet chaos! The ultimate destination for memes, lightsticks, and endless fan moments."), 0x1::string::utf8(b"https://popularsui.xyz/media/68f67b3f16eb24547e7c285320cd174e0c7054d4a4f98008fbc9ca21cd51a966.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<KPOP>>(0x2::coin_registry::finalize<KPOP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

