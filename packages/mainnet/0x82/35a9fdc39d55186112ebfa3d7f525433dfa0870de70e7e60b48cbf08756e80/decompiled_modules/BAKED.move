module 0x8235a9fdc39d55186112ebfa3d7f525433dfa0870de70e7e60b48cbf08756e80::BAKED {
    struct BAKED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAKED>, arg1: 0x2::coin::Coin<BAKED>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BAKED>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAKED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BAKED>>(0x2::coin::mint<BAKED>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<BAKED>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BAKED>>(arg0);
    }

    fun init(arg0: BAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKED>(arg0, 9, b"BAKED", b"Baked Sui Buds", b"Baked Sui Buds is a cosmic cannabis culture brand on Sui blockchain, Guided by the High council of Kush terra, our mission is to blend chill vibes with smart rewards, building a digital universe where community and collects sharp the future together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68c02c7af27520.84569326.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

