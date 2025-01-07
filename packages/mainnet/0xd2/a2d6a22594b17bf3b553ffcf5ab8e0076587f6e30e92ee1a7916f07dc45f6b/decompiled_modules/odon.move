module 0xd2a2d6a22594b17bf3b553ffcf5ab8e0076587f6e30e92ee1a7916f07dc45f6b::odon {
    struct ODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODON>(arg0, 6, b"ODON", b"SuiOdon", b"$Odon is the Wealth Protector on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960549412.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

