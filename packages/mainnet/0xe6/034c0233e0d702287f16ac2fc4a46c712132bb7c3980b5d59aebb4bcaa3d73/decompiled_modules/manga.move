module 0xe6034c0233e0d702287f16ac2fc4a46c712132bb7c3980b5d59aebb4bcaa3d73::manga {
    struct MANGA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANGA>, arg1: 0x2::coin::Coin<MANGA>) {
        0x2::coin::burn<MANGA>(arg0, arg1);
    }

    fun init(arg0: MANGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANGA>(arg0, 2, b"MANGA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANGA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANGA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

