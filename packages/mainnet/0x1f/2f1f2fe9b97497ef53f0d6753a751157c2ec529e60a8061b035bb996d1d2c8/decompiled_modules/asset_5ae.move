module 0x1f2f1f2fe9b97497ef53f0d6753a751157c2ec529e60a8061b035bb996d1d2c8::asset_5ae {
    struct ASSET_5AE has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<ASSET_5AE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_5AE> {
        0x2::coin::mint<ASSET_5AE>(arg0, arg1, arg2)
    }

    public entry fun create_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_5AE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_5AE>>(0x2::coin::mint<ASSET_5AE>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_5AE>, arg1: 0x2::coin::Coin<ASSET_5AE>) {
        0x2::coin::burn<ASSET_5AE>(arg0, arg1);
    }

    fun init(arg0: ASSET_5AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_5AE>(arg0, 9, b"NS", b"SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-GRKPYMiR86.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_5AE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_5AE>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

