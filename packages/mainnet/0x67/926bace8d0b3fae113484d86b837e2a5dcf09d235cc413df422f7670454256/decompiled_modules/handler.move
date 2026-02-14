module 0x67926bace8d0b3fae113484d86b837e2a5dcf09d235cc413df422f7670454256::handler {
    struct HANDLER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: 0x2::coin::Coin<HANDLER>) {
        0x2::coin::burn<HANDLER>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER> {
        0x2::coin::mint<HANDLER>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER>>(0x2::coin::mint<HANDLER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-bzs5wfG2Te.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

