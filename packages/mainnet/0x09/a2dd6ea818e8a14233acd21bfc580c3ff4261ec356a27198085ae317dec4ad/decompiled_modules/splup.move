module 0x9a2dd6ea818e8a14233acd21bfc580c3ff4261ec356a27198085ae317dec4ad::splup {
    struct SPLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLUP>(arg0, 6, b"SPLUP", b"Suiplup", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihiddqqxgkgi4lojmkogyni35z7jz4nckv3qlekejvasbi55obzy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

