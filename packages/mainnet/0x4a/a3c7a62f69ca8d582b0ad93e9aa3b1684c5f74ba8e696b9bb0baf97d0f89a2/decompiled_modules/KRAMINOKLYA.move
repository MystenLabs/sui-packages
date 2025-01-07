module 0x4aa3c7a62f69ca8d582b0ad93e9aa3b1684c5f74ba8e696b9bb0baf97d0f89a2::KRAMINOKLYA {
    struct KRAMINOKLYA has drop {
        dummy_field: bool,
    }

    struct MintingConfig has key {
        id: 0x2::object::UID,
        is_minting_allowed: bool,
    }

    fun init(arg0: KRAMINOKLYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAMINOKLYA>(arg0, 9, b"GLOOMS3", b"GLOOMS3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmUHmJYJxpesWgc7ZdE5HjJKkoN4f5e1uKDyd5cCrA3ujy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAMINOKLYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAMINOKLYA>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = MintingConfig{
            id                 : 0x2::object::new(arg1),
            is_minting_allowed : true,
        };
        0x2::transfer::transfer<MintingConfig>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KRAMINOKLYA>, arg1: &MintingConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_minting_allowed, 1);
        0x2::coin::mint_and_transfer<KRAMINOKLYA>(arg0, arg2, arg3, arg4);
    }

    public entry fun set_minting_allowed(arg0: &mut MintingConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x75e1637c6da630cea12cbaa47940b0d67bf59aed31e728ddc05184ed7f11fc19, 0);
        arg0.is_minting_allowed = arg1;
    }

    // decompiled from Move bytecode v6
}

