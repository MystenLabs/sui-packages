module 0x91383ef05a8f624150b3bc68be54dbb51bb915922846160d33c29349d8a4b079::kundingwhale {
    struct KUNDINGWHALE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KUNDINGWHALE>, arg1: 0x2::coin::Coin<KUNDINGWHALE>) {
        0x2::coin::burn<KUNDINGWHALE>(arg0, arg1);
    }

    fun init(arg0: KUNDINGWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNDINGWHALE>(arg0, 6, b"KUNDINGWHALE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUNDINGWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNDINGWHALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KUNDINGWHALE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KUNDINGWHALE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

