module 0x9d59cbebff89c5a7578ed58600e6df2ae2d143ebf827369e8d9fb6091f55a6c1::module_d3b {
    struct MODULE_D3B has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MODULE_D3B>, arg1: 0x2::coin::Coin<MODULE_D3B>) {
        0x2::coin::burn<MODULE_D3B>(arg0, arg1);
    }

    fun init(arg0: MODULE_D3B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODULE_D3B>(arg0, 9, b"CETUS", b"Cetus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-2eERL1Bati.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MODULE_D3B>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODULE_D3B>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<MODULE_D3B>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MODULE_D3B> {
        0x2::coin::mint<MODULE_D3B>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<MODULE_D3B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MODULE_D3B>>(0x2::coin::mint<MODULE_D3B>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

