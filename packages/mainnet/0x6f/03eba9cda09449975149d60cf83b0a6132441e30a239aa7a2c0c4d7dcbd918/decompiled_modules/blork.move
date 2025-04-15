module 0x6f03eba9cda09449975149d60cf83b0a6132441e30a239aa7a2c0c4d7dcbd918::blork {
    struct BLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORK>(arg0, 6, b"Blork", b"MoonBlork", b"Quirky misfits rising from the depths. Mystery, mischief, and a splash of cute chaos. Blork doing Blork things. $sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiflh5dbhyyhhxcilavocdrga2l4ox2n22rjdovabxagnnl3cfopvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

