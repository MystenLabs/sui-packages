module 0xe4a32026edb683e53a32ea537a4e0f10770e5972ecc38d086f4b7c85c46742a9::icat {
    struct ICAT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ICAT>, arg1: 0x2::coin::Coin<ICAT>) {
        0x2::coin::burn<ICAT>(arg0, arg1);
    }

    fun init(arg0: ICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICAT>(arg0, 2, b"ICAT", b"icat", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ICAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ICAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

