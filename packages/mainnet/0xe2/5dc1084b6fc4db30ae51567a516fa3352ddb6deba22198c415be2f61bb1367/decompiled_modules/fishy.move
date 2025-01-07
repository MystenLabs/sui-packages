module 0xe25dc1084b6fc4db30ae51567a516fa3352ddb6deba22198c415be2f61bb1367::fishy {
    struct FISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHY>(arg0, 6, b"FISHY", b"Fishy Sui", b"$FISHY is the most unique and fortunate expressive fish in the Sui Ocean, staying true to its roots and bringing richness and dynamic energy to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001847_23ce9e0b0a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

