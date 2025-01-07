module 0xd25bcd031d2b29700c83fa0a2458bb7113648ef39d131a9b0012c0dd85cceb3a::cetusrock {
    struct CETUSROCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CETUSROCK>, arg1: 0x2::coin::Coin<CETUSROCK>) {
        0x2::coin::burn<CETUSROCK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUSROCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUSROCK>>(0x2::coin::mint<CETUSROCK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUSROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSROCK>(arg0, 9, b"CETUSROCK", b"CETUSROCK", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSROCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSROCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

