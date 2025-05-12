module 0x2250ce6e2f376444c15d12c5d1bc84bd2470ebb2fea3f30239b23148ecf1662e::swwuti {
    struct SWWUTI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWWUTI>, arg1: 0x2::coin::Coin<SWWUTI>) {
        0x2::coin::burn<SWWUTI>(arg0, arg1);
    }

    fun init(arg0: SWWUTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWWUTI>(arg0, 2, b"SWWUTI", b"swwuew", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWWUTI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 1000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWWUTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWWUTI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWWUTI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

