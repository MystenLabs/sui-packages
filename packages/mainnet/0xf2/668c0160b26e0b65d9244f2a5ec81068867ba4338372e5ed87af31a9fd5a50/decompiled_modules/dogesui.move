module 0xf2668c0160b26e0b65d9244f2a5ec81068867ba4338372e5ed87af31a9fd5a50::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 6, b"DOGESUI", b"DOGE", b"D.O.G.E ( Department of Government Efficiency ) Now in SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731831627017.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

