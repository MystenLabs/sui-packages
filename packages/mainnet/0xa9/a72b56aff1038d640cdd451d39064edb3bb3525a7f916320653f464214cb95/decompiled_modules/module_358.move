module 0xa9a72b56aff1038d640cdd451d39064edb3bb3525a7f916320653f464214cb95::module_358 {
    struct MODULE_358 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MODULE_358>, arg1: 0x2::coin::Coin<MODULE_358>) {
        0x2::coin::burn<MODULE_358>(arg0, arg1);
    }

    fun init(arg0: MODULE_358, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODULE_358>(arg0, 9, b"suiUSDe", b"eSui Dollar", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-OZUUe_vwpS.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MODULE_358>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODULE_358>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<MODULE_358>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MODULE_358> {
        0x2::coin::mint<MODULE_358>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<MODULE_358>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MODULE_358>>(0x2::coin::mint<MODULE_358>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

