module 0xba9c5ad8aa41e941580dd3f0549711ac964492aaf31d90d60f51b6f432e37722::vayne {
    struct VAYNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAYNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAYNE>(arg0, 6, b"Vayne", b"Vayne on Sui", b"Vayne slayer three star on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAYNE>>(v1);
        0x2::coin::mint_and_transfer<VAYNE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAYNE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<VAYNE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VAYNE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

