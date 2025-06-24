module 0x76c8fef2a349481a8ff159c53741f016195eb4fe3f123f9bba7f261e0bd5a2db::chompy {
    struct CHOMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPY>(arg0, 6, b"CHOMPY", b"CHOMP", b"the bald-headed mastermind behind has a childhood pet, a mysterious iguana that played a huge role in shaping his journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqwm5l7tlixyvjaeijoidfrk7k5m7ct5oymqand2mr6cqu5olflm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOMPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

