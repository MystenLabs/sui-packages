module 0xb0b73742895cd363fe5d0ebe81fbd809b6c7bb7092a63f59ec7f97db62a10bfe::shuning0312_usd {
    struct SHUNING0312_USD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHUNING0312_USD>, arg1: 0x2::coin::Coin<SHUNING0312_USD>) {
        0x2::coin::burn<SHUNING0312_USD>(arg0, arg1);
    }

    fun init(arg0: SHUNING0312_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUNING0312_USD>(arg0, 8, b"SHUNING0312_USD", b"SHUNING0312_USD", b"this is my_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUNING0312_USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUNING0312_USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUNING0312_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHUNING0312_USD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

