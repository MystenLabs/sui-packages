module 0xf241cfa39ae19dba88cd88c83ab0f41f18bd3c7000982af6b6c3b8bb455a074f::KAMASUI {
    struct KAMASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAMASUI>, arg1: 0x2::coin::Coin<KAMASUI>) {
        0x2::coin::burn<KAMASUI>(arg0, arg1);
    }

    fun init(arg0: KAMASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMASUI>(arg0, 9, b"KMU", b"KAMASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAMASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAMASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

