module 0x87bffbc162b58e6f2fe4571748ce6267ed575e50f65d80f6fc47804653858851::asset_068 {
    struct ASSET_068 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_068>, arg1: 0x2::coin::Coin<ASSET_068>) {
        0x2::coin::burn<ASSET_068>(arg0, arg1);
    }

    fun init(arg0: ASSET_068, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_068>(arg0, 9, b"DEEP", b"DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-UrNax5WoBo.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_068>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_068>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<ASSET_068>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_068> {
        0x2::coin::mint<ASSET_068>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_068>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_068>>(0x2::coin::mint<ASSET_068>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

