module 0x8281101905c05cd8cd7e2f87133e9c8513628a7988daf43d1348d1a5904cc7c0::NEO {
    struct NEO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: 0x2::coin::Coin<NEO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<NEO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEO>>(0x2::coin::mint<NEO>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<NEO>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEO>>(arg0);
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 9, b"NEO", b"NeoNeko", b"Welcome to the one and only place to watch Anime as a community and earn rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_69006b2f7490d3.98412775.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

