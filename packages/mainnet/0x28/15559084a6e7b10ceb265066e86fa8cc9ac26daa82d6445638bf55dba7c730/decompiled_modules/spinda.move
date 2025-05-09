module 0x2815559084a6e7b10ceb265066e86fa8cc9ac26daa82d6445638bf55dba7c730::spinda {
    struct SPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDA>(arg0, 6, b"SPINDA", b"Spinda on Sui", b"Spinda stan  | Drunk on Sui chain  | Spinning memes into cosmic chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp26ibysbyt34jlaq7x7qrpz255dy3fuaoqjfcrikk7owj2snmfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

