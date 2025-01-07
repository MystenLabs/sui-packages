module 0xd223b1505cab6412af41d62ca4c20662c91163b8f4a661da39d75b958ba52bd::squish {
    struct SQUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUISH>(arg0, 6, b"Squish", b"Squish Sui", b"The most Inky Octo-pal, Squishy, squishy, Sui's new buddy. Your eight-armed guide to the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964420856.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

