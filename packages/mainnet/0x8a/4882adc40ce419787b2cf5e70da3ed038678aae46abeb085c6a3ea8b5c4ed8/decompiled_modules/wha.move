module 0x8a4882adc40ce419787b2cf5e70da3ed038678aae46abeb085c6a3ea8b5c4ed8::wha {
    struct WHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: 0x2::coin::Coin<WHA>) {
        0x2::coin::burn<WHA>(arg0, arg1);
    }

    fun init(arg0: WHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHA>(arg0, 4, b"WHA", b"WHA", b"Whales keep Ocean health, just as Whaleme keeps SUI Ocean wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://whaleme.me/images/token.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x24de41e1ead4cdc5dc899459323884d4be770021825515302a55f7b5b663edbb, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHA>>(v2, @0x24de41e1ead4cdc5dc899459323884d4be770021825515302a55f7b5b663edbb);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WHA>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WHA>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

