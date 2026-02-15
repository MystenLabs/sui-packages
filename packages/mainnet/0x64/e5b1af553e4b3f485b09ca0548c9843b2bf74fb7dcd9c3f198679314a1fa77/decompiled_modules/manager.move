module 0x64e5b1af553e4b3f485b09ca0548c9843b2bf74fb7dcd9c3f198679314a1fa77::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: 0x2::coin::Coin<MANAGER>) {
        0x2::coin::burn<MANAGER>(arg0, arg1);
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER>(arg0, 9, b"wWAL", b"Wrapped WAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-TvcbwnGLAd.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MANAGER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGER>>(v1);
    }

    public fun make(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MANAGER> {
        0x2::coin::mint<MANAGER>(arg0, arg1, arg2)
    }

    public entry fun make_to(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGER>>(0x2::coin::mint<MANAGER>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

