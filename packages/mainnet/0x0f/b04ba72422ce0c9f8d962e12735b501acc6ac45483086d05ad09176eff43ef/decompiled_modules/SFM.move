module 0xfb04ba72422ce0c9f8d962e12735b501acc6ac45483086d05ad09176eff43ef::SFM {
    struct SFM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SFM>, arg1: 0x2::coin::Coin<SFM>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SFM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SFM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SFM>>(0x2::coin::mint<SFM>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<SFM>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SFM>>(arg0);
    }

    fun init(arg0: SFM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFM>(arg0, 9, b"SFM", b"Safemoon on Sui", b"Safemoon is now on SUI and provides Rewards for holding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/HfYFfgfJ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

