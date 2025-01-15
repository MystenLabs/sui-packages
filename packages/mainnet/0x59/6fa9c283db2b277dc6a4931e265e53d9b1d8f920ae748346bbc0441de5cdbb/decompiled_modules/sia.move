module 0x596fa9c283db2b277dc6a4931e265e53d9b1d8f920ae748346bbc0441de5cdbb::sia {
    struct SIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIA>(arg0, 6, b"SIA", b"SIRIUS AI", b"Sirius AI is the first decentralized AI network designed to empower anyone, individuals and businesses, to deploy and use personalized, autonomous AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul83_20250115171210_eeda6d265a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

