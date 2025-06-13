module 0xdcd98dcd828ac1e87c4dd374ed43a02ac0fc30fa73b5ab2b7e4aefde64125354::TESTA {
    struct TESTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTA>, arg1: 0x2::coin::Coin<TESTA>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TESTA>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTA>>(0x2::coin::mint<TESTA>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TESTA>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTA>>(arg0);
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 9, b"TESTA", b"Test A", b"This is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_684c6e76c5ca24.10126703.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

