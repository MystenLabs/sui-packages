module 0x6d75773fde97336e256df7fafec74bc40de0f3aaf08f967cee28c6d33c76ffa9::woodwhale {
    struct WOODWHALE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WOODWHALE>, arg1: 0x2::coin::Coin<WOODWHALE>) {
        0x2::coin::burn<WOODWHALE>(arg0, arg1);
    }

    fun init(arg0: WOODWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODWHALE>(arg0, 6, b"WOODWHALE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOODWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODWHALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WOODWHALE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WOODWHALE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

