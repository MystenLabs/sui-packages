module 0x95c11a760eedfa3dc81b70311aa59e577bb04886a8e3d9f7a24ab538215f8b23::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISHIB>, arg1: 0x2::coin::Coin<SUISHIB>) {
        0x2::coin::burn<SUISHIB>(arg0, arg1);
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 2, b"SUISHIB", b"SUISHIB", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

