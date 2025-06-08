module 0x575b82492634cc09c9217dab3651fcae8d1fb60cf73dbdf6fd2a08c308b6a9f1::situss {
    struct SITUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SITUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITUSS>(arg0, 6, b"SITUSS", b"SITUS", b"SITUSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiddj6g4llfvhwke6ahiw66dj6w5zkwnh66bvoha6s6vi6pljhhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SITUSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

