module 0x65944353871e4d3bec22d67efb34a92d3916db1ef39693feb7035f98bb098ae4::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: 0x2::coin::Coin<BOSU>) {
        0x2::coin::burn<BOSU>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<BOSU>) : u64 {
        0x2::coin::total_supply<BOSU>(arg0)
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOOK OF SUI", b"BOSU", b"BOOK OF SUI token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/token-assets/refs/heads/main/Bookofsui.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOSU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

