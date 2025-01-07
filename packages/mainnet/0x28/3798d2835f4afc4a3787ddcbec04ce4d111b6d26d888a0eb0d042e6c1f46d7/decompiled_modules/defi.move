module 0x283798d2835f4afc4a3787ddcbec04ce4d111b6d26d888a0eb0d042e6c1f46d7::defi {
    struct DEFI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEFI>, arg1: 0x2::coin::Coin<DEFI>) {
        0x2::coin::burn<DEFI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEFI>>(0x2::coin::mint<DEFI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFI>(arg0, 9, b"defi", b"DEFI", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"example.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

