module 0xad488d98a8fe50a8640e0b0a9a763a054f1d428e9f0edaec94f49d658b1875de::pgsui {
    struct PGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGSUI>(arg0, 6, b"PEPEGS", b"PEPE GIRL SUI", b"Tele: https://t.me/bitshib_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/lBfo9bW.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGSUI>>(v0, @0xfc9d5621b30b4b1b0c023a33c4f8683d02daad1045edd3b6018adbb12ec8fcfb);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PGSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PGSUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

