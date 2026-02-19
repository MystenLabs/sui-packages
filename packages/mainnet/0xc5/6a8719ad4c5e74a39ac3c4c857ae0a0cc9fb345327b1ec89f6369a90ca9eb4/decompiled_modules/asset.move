module 0xc56a8719ad4c5e74a39ac3c4c857ae0a0cc9fb345327b1ec89f6369a90ca9eb4::asset {
    struct ASSET has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: 0x2::coin::Coin<ASSET>) {
        0x2::coin::burn<ASSET>(arg0, arg1);
    }

    fun init(arg0: ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET> {
        0x2::coin::mint<ASSET>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET>>(0x2::coin::mint<ASSET>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

