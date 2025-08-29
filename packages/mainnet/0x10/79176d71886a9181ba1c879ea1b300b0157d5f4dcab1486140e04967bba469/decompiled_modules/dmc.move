module 0x1079176d71886a9181ba1c879ea1b300b0157d5f4dcab1486140e04967bba469::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DMC>, arg1: 0x2::coin::Coin<DMC>) : u64 {
        0x2::coin::burn<DMC>(arg0, arg1)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DMC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DMC>>(arg0, arg1);
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMC>(arg0, 0, b"DMC", b"Sparda", b"Sparda tokens, 666 minted. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/000/622/795/non_2x/vector-s-letter-logo.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMC>>(v1);
        let v3 = @0xd06df023207505825a3c39ef22a3b67c1bb31b8adb7744969352fdf171ec2557;
        0x2::coin::mint_and_transfer<DMC>(&mut v2, 666, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMC>>(v2, v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DMC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DMC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

