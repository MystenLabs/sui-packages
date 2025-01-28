module 0x4f60ce51132a9b5c86634994efd4cbc4605da1ce6cc32e1662e37271f0a1e4a7::fortyseventhpresident {
    struct FORTYSEVENTHPRESIDENT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>, arg1: 0x2::coin::Coin<FORTYSEVENTHPRESIDENT>) {
        0x2::coin::burn<FORTYSEVENTHPRESIDENT>(arg0, arg1);
    }

    fun init(arg0: FORTYSEVENTHPRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTYSEVENTHPRESIDENT>(arg0, 9, b"SYMBOL", b"NAME", b"DESCRIPTION", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORTYSEVENTHPRESIDENT>>(v1);
        0x2::coin::mint_and_transfer<FORTYSEVENTHPRESIDENT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FORTYSEVENTHPRESIDENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

