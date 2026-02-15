module 0x24934b5a459513e93e0535b1af485306e61bd30b7bd4f2a3b1489f02a1667782::unit_eb8 {
    struct UNIT_EB8 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<UNIT_EB8>, arg1: 0x2::coin::Coin<UNIT_EB8>) {
        0x2::coin::burn<UNIT_EB8>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<UNIT_EB8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UNIT_EB8> {
        0x2::coin::mint<UNIT_EB8>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<UNIT_EB8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UNIT_EB8>>(0x2::coin::mint<UNIT_EB8>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: UNIT_EB8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIT_EB8>(arg0, 9, b"SCA", b"Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-bYuIO_pK4j.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<UNIT_EB8>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIT_EB8>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

