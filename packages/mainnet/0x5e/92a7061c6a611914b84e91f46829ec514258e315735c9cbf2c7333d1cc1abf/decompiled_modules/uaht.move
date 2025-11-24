module 0x5e92a7061c6a611914b84e91f46829ec514258e315735c9cbf2c7333d1cc1abf::uaht {
    struct UAHT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<UAHT>, arg1: 0x2::coin::Coin<UAHT>) {
        0x2::coin::burn<UAHT>(arg0, arg1);
    }

    fun init(arg0: UAHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UAHT>(arg0, 9, b" UAHT ", b" UAHT ", b"This is UAHT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/4/43/UAHT_Logo_Red.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UAHT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UAHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<UAHT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<UAHT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

