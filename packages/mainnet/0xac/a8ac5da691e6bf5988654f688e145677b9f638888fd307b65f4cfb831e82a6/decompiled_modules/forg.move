module 0xaca8ac5da691e6bf5988654f688e145677b9f638888fd307b65f4cfb831e82a6::forg {
    struct FORG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FORG>, arg1: 0x2::coin::Coin<FORG>) {
        0x2::coin::burn<FORG>(arg0, arg1);
    }

    fun init(arg0: FORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORG>(arg0, 2, b"FORG", b"FORG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FORG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FORG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

