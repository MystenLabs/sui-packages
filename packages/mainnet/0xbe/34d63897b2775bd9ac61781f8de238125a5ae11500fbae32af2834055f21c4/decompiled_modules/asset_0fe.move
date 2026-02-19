module 0xbe34d63897b2775bd9ac61781f8de238125a5ae11500fbae32af2834055f21c4::asset_0fe {
    struct ASSET_0FE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ASSET_0FE>, arg1: 0x2::coin::Coin<ASSET_0FE>) {
        0x2::coin::burn<ASSET_0FE>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<ASSET_0FE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ASSET_0FE> {
        0x2::coin::mint<ASSET_0FE>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<ASSET_0FE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET_0FE>>(0x2::coin::mint<ASSET_0FE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ASSET_0FE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET_0FE>(arg0, 9, b"cUSD", b"Wrapped cUSD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-fONhaTaj9C.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ASSET_0FE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET_0FE>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

