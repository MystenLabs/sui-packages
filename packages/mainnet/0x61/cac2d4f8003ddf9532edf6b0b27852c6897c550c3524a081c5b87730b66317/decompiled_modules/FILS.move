module 0x61cac2d4f8003ddf9532edf6b0b27852c6897c550c3524a081c5b87730b66317::FILS {
    struct FILS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FILS>, arg1: 0x2::coin::Coin<FILS>) {
        0x2::coin::burn<FILS>(arg0, arg1);
    }

    fun init(arg0: FILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILS>(arg0, 2, b"KG Offset", b"KG", b"Offset coins issued by Fils. Each coin represents 1 kg of carbon offset", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FILS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FILS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FILS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

