module 0xd980683242005390866d8c4e7206dc098fc88b20ef05df281b0c3b265b11b44::suibaru {
    struct SUIBARU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBARU>, arg1: 0x2::coin::Coin<SUIBARU>) {
        0x2::coin::burn<SUIBARU>(arg0, arg1);
    }

    fun init(arg0: SUIBARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBARU>(arg0, 6, b"SUIBARU", b"@SuibaruOnSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBARU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBARU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBARU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBARU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

