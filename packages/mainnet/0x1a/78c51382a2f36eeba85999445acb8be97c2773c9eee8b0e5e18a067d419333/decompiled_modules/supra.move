module 0x1a78c51382a2f36eeba85999445acb8be97c2773c9eee8b0e5e18a067d419333::supra {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SUPRA>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) != @0x4f5828a97eced4deebdd303bd95538f6cf8105d0115bc14e067ec633dd4b1cfc) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg0, arg1);
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

    public entry fun transfer_from(arg0: address, arg1: 0x2::coin::Coin<SUPRA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg3) != @0x4f5828a97eced4deebdd303bd95538f6cf8105d0115bc14e067ec633dd4b1cfc) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUPRA>>(arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

