module 0x5980896fbc6466df233276f5b6b1910b98ca1268a6bfe75487cb11bd1c178ffb::SLAMBO {
    struct SLAMBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLAMBO>, arg1: 0x2::coin::Coin<SLAMBO>) {
        0x2::coin::burn<SLAMBO>(arg0, arg1);
    }

    fun init(arg0: SLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAMBO>(arg0, 2, b"SLAMBO", b"SUILAMBO", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLAMBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLAMBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

