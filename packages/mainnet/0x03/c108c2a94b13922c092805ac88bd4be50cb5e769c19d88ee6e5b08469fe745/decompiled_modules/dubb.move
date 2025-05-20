module 0x3c108c2a94b13922c092805ac88bd4be50cb5e769c19d88ee6e5b08469fe745::dubb {
    struct DUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBB>(arg0, 6, b"DUBB", b"DUBBIN AROUND", b"Hey my name is Dubb, im Dubbin around SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigoxs4piiivulmt7cl4tddktfpzp3ydbmmo5nucdj2f6yfjzeg67y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUBB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

