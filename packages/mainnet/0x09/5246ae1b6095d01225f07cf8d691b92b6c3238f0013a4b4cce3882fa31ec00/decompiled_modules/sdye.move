module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::sdye {
    struct SDYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDYE>(arg0, 9, b"SDYE", b"Self-Driving Yield Engine", b"SDYE share token for the Self-Driving Yield Engine vault.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_shares(arg0: &mut 0x2::coin::TreasuryCap<SDYE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SDYE> {
        0x2::coin::mint<SDYE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

