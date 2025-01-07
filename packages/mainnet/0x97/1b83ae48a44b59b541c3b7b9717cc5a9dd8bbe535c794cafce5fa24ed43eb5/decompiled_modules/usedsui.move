module 0x971b83ae48a44b59b541c3b7b9717cc5a9dd8bbe535c794cafce5fa24ed43eb5::usedsui {
    struct USEDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USEDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USEDSUI>(arg0, 9, b"USEDSUI", b"A GENTLY USED SUI CHAIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USEDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USEDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USEDSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USEDSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

