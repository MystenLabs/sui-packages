module 0x1aa6dc3ac946b055fd9b38322f51cee3e950332c330ae67915af65a0579530c2::bifie {
    struct BIFIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIFIE>, arg1: 0x2::coin::Coin<BIFIE>) {
        0x2::coin::burn<BIFIE>(arg0, arg1);
    }

    fun init(arg0: BIFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIFIE>(arg0, 9, b"BIFIE", b"Bifie Coin", b"BifiPal: A financial protocol and one-stop financial service based on Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bifipal.com/BifiPal-logo.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIFIE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIFIE>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIFIE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BIFIE>(arg0) <= 2100000000000000000, 0);
        0x2::coin::mint_and_transfer<BIFIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

