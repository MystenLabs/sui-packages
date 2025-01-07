module 0xc00555e0431ba6745b910587e1f16ec32faf3d84af756e49dedc54b3ac1f68e2::wadeonsui {
    struct WADEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADEONSUI>(arg0, 6, b"WadeOnSui", b"Wade", x"53756974617264696f207c204275696c64696e6720636f6d6d756e6974696573206f6e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998951069.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WADEONSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADEONSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

