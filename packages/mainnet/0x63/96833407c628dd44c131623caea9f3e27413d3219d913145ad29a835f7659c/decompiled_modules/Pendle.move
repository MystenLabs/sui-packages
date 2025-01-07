module 0x6396833407c628dd44c131623caea9f3e27413d3219d913145ad29a835f7659c::Pendle {
    struct PENDLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PENDLE>, arg1: 0x2::coin::Coin<PENDLE>) {
        0x2::coin::burn<PENDLE>(arg0, arg1);
    }

    fun init(arg0: PENDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDLE>(arg0, 8, b"Pendle", b"Pendle", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/15069/small/Pendle_Logo_Normal-03.png?1634196276")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENDLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PENDLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PENDLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

