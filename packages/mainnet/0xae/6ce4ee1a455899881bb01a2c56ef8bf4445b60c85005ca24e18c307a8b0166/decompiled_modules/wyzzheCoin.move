module 0xae6ce4ee1a455899881bb01a2c56ef8bf4445b60c85005ca24e18c307a8b0166::wyzzheCoin {
    struct WYZZHECOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WYZZHECOIN>, arg1: 0x2::coin::Coin<WYZZHECOIN>) {
        0x2::coin::burn<WYZZHECOIN>(arg0, arg1);
    }

    fun init(arg0: WYZZHECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYZZHECOIN>(arg0, 6, b"WYZZHECOIN", b"WYZ", b"Power by wyz", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYZZHECOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYZZHECOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WYZZHECOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WYZZHECOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

