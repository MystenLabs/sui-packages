module 0x971649c885e829c6ba0df95bb4967b1c39306ba22aaf71f79be6ad36cd9d8b29::dobo {
    struct DOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBO>(arg0, 6, b"DOBO", b"Dogebonk", x"455645525944415920494d20424f4e4b454e494e470a4e4f20574542534954452c204e4f20534f4349414c532c204f4e4c5920424f4e4b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dobo_b469ea2e66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

