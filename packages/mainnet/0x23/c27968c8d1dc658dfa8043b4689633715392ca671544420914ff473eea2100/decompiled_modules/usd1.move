module 0x23c27968c8d1dc658dfa8043b4689633715392ca671544420914ff473eea2100::usd1 {
    struct USD1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USD1>, arg1: 0x2::coin::Coin<USD1>) {
        0x2::coin::burn<USD1>(arg0, arg1);
    }

    fun init(arg0: USD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD1>(arg0, 9, b"USD1", b"USD1", b"This is USD1. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/JAwD3WuvZBoiBootBFwF8yRHCVJngepQaEDTpySDgzs5")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USD1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USD1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USD1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

