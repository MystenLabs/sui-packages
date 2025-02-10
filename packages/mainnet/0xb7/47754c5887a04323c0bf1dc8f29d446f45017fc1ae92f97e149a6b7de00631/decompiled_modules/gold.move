module 0xb747754c5887a04323c0bf1dc8f29d446f45017fc1ae92f97e149a6b7de00631::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLD>>(0x2::coin::mint<GOLD>(arg0, arg1, arg3), arg2);
    }

    entry fun change_admin(arg0: address, arg1: 0x2::coin::TreasuryCap<GOLD>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(arg1, arg0);
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"GD", b"Gold winnings from game Deceit", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

