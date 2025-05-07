module 0x97956a69046d25f4ed7d5cfb77d2717a4241993c29a0edc272ee16d45e29ad64::factory {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    public entry fun create_token(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<MY_TOKEN>(v0, arg4, 0x1::string::into_bytes(arg0), 0x1::string::into_bytes(arg1), 0x1::string::into_bytes(arg2), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg3))), arg8);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v2);
        0x2::coin::mint_and_transfer<MY_TOKEN>(&mut v3, arg5, arg6, arg8);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v3, arg7);
    }

    // decompiled from Move bytecode v6
}

