module 0xfc65c8c18670391d0c1e92ce3f5ca755fbb6194d0aa1d73ada6bfda5a71a63eb::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOND>(arg0, 6, b"BOND", b"BOND Agent", b"007 Agent on $SUI has a mission and is to $BOND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736097362219.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

