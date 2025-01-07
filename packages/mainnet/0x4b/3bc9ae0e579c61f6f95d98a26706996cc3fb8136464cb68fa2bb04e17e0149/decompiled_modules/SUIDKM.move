module 0x4b3bc9ae0e579c61f6f95d98a26706996cc3fb8136464cb68fa2bb04e17e0149::SUIDKM {
    struct SUIDKM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIDKM>, arg1: 0x2::coin::Coin<SUIDKM>) {
        0x2::coin::burn<SUIDKM>(arg0, arg1);
    }

    fun init(arg0: SUIDKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDKM>(arg0, 9, b"DKM", b"SUIDKM", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDKM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDKM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDKM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDKM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

