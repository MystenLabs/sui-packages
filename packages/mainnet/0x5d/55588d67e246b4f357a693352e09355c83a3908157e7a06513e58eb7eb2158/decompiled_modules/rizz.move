module 0x5d55588d67e246b4f357a693352e09355c83a3908157e7a06513e58eb7eb2158::rizz {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ", b"Rizzmas on Sui", x"43616e20776520626f6e64202452495a5a2054696c6c204368726973746d6173203f0a0a48617070792052697a7a6d6173", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavp26begpm3eiidi6xqcmtcuqyqjtv3n3ei47fqsdk6vnw4kfc5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIZZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

