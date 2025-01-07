module 0x9da70907c30d1403aead4e3ec54d6ef335afe9dbd496fe860494bb6b7cc77b16::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: 0x2::coin::Coin<SUICAT>) {
        0x2::coin::burn<SUICAT>(arg0, arg1);
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 2, b"SUICAT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

