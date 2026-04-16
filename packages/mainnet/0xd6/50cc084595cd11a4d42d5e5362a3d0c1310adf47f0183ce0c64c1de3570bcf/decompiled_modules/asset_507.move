module 0xd650cc084595cd11a4d42d5e5362a3d0c1310adf47f0183ce0c64c1de3570bcf::asset_507 {
    struct ASSET_507 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_507>, arg1: 0x2::coin::Coin<ASSET_507>) {
        0x2::coin::burn<ASSET_507>(arg0, arg1);
    }

    fun init(arg0: ASSET_507, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_507>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_507>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_507>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<ASSET_507>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_507> {
        0x2::coin::mint<ASSET_507>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_507>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_507>>(0x2::coin::mint<ASSET_507>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

