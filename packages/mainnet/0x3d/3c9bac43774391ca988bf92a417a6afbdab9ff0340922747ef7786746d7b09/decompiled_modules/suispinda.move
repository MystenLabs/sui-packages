module 0x3d3c9bac43774391ca988bf92a417a6afbdab9ff0340922747ef7786746d7b09::suispinda {
    struct SUISPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPINDA>(arg0, 6, b"SUISPINDA", b"Spinda on SUI", b"Spinda stan  | Drunk on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibp26ibysbyt34jlaq7x7qrpz255dy3fuaoqjfcrikk7owj2snmfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

