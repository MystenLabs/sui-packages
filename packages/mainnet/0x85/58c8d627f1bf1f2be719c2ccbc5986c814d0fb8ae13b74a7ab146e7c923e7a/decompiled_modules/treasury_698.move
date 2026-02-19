module 0x8558c8d627f1bf1f2be719c2ccbc5986c814d0fb8ae13b74a7ab146e7c923e7a::treasury_698 {
    struct TREASURY_698 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_698>, arg1: 0x2::coin::Coin<TREASURY_698>) {
        0x2::coin::burn<TREASURY_698>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_698>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TREASURY_698> {
        0x2::coin::mint<TREASURY_698>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<TREASURY_698>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TREASURY_698>>(0x2::coin::mint<TREASURY_698>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TREASURY_698, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASURY_698>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-igxyUUMm3e.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREASURY_698>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREASURY_698>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

