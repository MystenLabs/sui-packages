module 0x555ef36cc4b3a3e1221345de22452aab9fb406813c1bfc4f780c93ac21c5c381::lr {
    struct LR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LR>(arg0, 6, b"LR", b"LET ROOTS", b"LR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiewgcqjfp5lruxjh2hlhsj67awp6ctd53ou45w57kgxfcuvf6vd2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

