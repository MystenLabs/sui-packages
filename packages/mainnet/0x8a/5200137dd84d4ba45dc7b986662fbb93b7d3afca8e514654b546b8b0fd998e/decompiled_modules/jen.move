module 0x8a5200137dd84d4ba45dc7b986662fbb93b7d3afca8e514654b546b8b0fd998e::jen {
    struct JEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JEN>, arg1: 0x2::coin::Coin<JEN>) {
        0x2::coin::burn<JEN>(arg0, arg1);
    }

    fun init(arg0: JEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEN>(arg0, 9, b"JEN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

