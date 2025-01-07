module 0x2f3b4e43ab3b01dea5878c14aa132217725441aa68de48312445ab17fe778d1c::twtr {
    struct TWTR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TWTR>, arg1: 0x2::coin::Coin<TWTR>) {
        0x2::coin::burn<TWTR>(arg0, arg1);
    }

    fun init(arg0: TWTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWTR>(arg0, 4, b"TWTR", b"TWTR", b"TWTR coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x6982508145454ce325ddbe47a25d4ec3d2311933.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x5002247a747ccf9ca743726a9a768247e3ebea204e247f23a3b4c6f212db30d0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWTR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TWTR>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<TWTR>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TWTR>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

