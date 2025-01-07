module 0xc570d3d2910473578c2a268cbeab362253613d5c29c92904d851cbceed5c89ac::antigone4224c {
    struct ANTIGONE4224C has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANTIGONE4224C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ANTIGONE4224C>>(0x2::coin::mint<ANTIGONE4224C>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ANTIGONE4224C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTIGONE4224C>(arg0, 6, b"ANTIGONE4224C", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTIGONE4224C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTIGONE4224C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

