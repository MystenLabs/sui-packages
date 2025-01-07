module 0x157008f9c133c3357edbf19bb14ac371b2d7d0c3efdfb9e12544e92fd824edbf::monsui {
    struct MONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSUI>(arg0, 6, b"MonSui", b"MonSui Cat", b"There has been a shift in the crypto winds. There is a storm brewing on $SUI.  Not your average cute kitty ticker, This Cat will bring the rain. Are you prepared for the months ahead? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950194486.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

