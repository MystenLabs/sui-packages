module 0xec87fadc379b2bce850b9fbff26c4c689ddff13b3acd47cb3be106ddf4ab52f9::supra {
    struct SUPRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: 0x2::coin::Coin<SUPRA>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != @0x4f5828a97eced4deebdd303bd95538f6cf8105d0115bc14e067ec633dd4b1cfc) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::burn<SUPRA>(arg0, arg1);
        };
    }

    fun init(arg0: SUPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPRA>(arg0, 9, b"SUP", b"SUPRA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRA>(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<SUPRA>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 == @0x4f4556edceebd57fe020455ac6af6f05cf42cc4ea059ad44420ba4feecac8aa1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg0, 0x2::tx_context::sender(arg2));
            abort 1001
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

