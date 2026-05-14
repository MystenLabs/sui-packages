module 0x91171146d8841708bd85481fdb424c12fbafd35a48516266e83dd7d3899e75ab::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    public entry fun attack_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Sui", b"The native token of the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/sui-sui-logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(0x2::coin::mint<SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

