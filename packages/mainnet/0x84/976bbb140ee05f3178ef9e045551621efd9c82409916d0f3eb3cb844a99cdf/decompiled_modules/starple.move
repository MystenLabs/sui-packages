module 0x84976bbb140ee05f3178ef9e045551621efd9c82409916d0f3eb3cb844a99cdf::starple {
    struct STARPLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STARPLE>, arg1: 0x2::coin::Coin<STARPLE>) {
        0x2::coin::burn<STARPLE>(arg0, arg1);
    }

    fun init(arg0: STARPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARPLE>(arg0, 6, b"STP", b"STARPLE", b"native token of the game", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STARPLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STARPLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

