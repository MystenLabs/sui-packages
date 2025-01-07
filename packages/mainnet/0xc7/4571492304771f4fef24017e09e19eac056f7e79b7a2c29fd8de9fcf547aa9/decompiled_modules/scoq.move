module 0xc74571492304771f4fef24017e09e19eac056f7e79b7a2c29fd8de9fcf547aa9::scoq {
    struct SCOQ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCOQ>, arg1: 0x2::coin::Coin<SCOQ>) {
        0x2::coin::burn<SCOQ>(arg0, arg1);
    }

    fun init(arg0: SCOQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOQ>(arg0, 2, b"SCOQ", b"SUICOQINU", b"COQ Inu on SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCOQ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCOQ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

