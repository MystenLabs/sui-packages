module 0xde964c346c5526bcc2f539f580ad6c06ebb2021db6a55b5b0828ccc308907d8d::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: 0x2::coin::Coin<REGISTRY>) {
        0x2::coin::burn<REGISTRY>(arg0, arg1);
    }

    public fun generate(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGISTRY> {
        0x2::coin::mint<REGISTRY>(arg0, arg1, arg2)
    }

    public entry fun generate_to(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGISTRY>>(0x2::coin::mint<REGISTRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGISTRY>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REGISTRY>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGISTRY>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

