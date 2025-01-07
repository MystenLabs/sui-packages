module 0x6555a95b149358347e15f78cdb6d087067d3a2c3b592a663d59d4de1171bc732::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AMA>, arg1: 0x2::coin::Coin<AMA>) {
        0x2::coin::burn<AMA>(arg0, arg1);
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Amalfi", b"Escape to the sunny Italian coast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidaoac6gi7x36z7mnexum4hq7twdglh5cl6jvcbl4ea32iugfrime.ipfs.w3s.link")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AMA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AMA>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<AMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

