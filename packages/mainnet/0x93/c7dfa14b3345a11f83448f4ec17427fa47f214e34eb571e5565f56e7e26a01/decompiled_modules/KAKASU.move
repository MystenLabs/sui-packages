module 0x93c7dfa14b3345a11f83448f4ec17427fa47f214e34eb571e5565f56e7e26a01::KAKASU {
    struct KAKASU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAKASU>, arg1: 0x2::coin::Coin<KAKASU>) {
        0x2::coin::burn<KAKASU>(arg0, arg1);
    }

    fun init(arg0: KAKASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKASU>(arg0, 9, b"KAKASU", b"KAKASU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKASU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKASU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAKASU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KAKASU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

