module 0x4f64accd2ba05b720fa5c7295ad52097de4231f4d459ebcb83f3064db559533e::kingdra {
    struct KINGDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDRA>(arg0, 6, b"KINGDRA", b"Kingdra on Sui", b"The King of Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicfbwio7ttjhs3hm6n2viys4zmxyp6coebb3imknvaegkn4mtdjb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

