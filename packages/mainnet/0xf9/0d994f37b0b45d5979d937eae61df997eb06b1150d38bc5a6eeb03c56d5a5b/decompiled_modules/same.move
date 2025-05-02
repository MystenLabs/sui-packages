module 0xf90d994f37b0b45d5979d937eae61df997eb06b1150d38bc5a6eeb03c56d5a5b::same {
    struct SAME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAME>, arg1: 0x2::coin::Coin<SAME>) {
        0x2::coin::burn<SAME>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SAME>>(0x2::coin::mint<SAME>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAME>(arg0, 9, b"SAME", b"SAME", b"SAME PLEASE", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

