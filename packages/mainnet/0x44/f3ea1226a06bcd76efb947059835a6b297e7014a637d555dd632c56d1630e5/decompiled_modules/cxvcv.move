module 0x44f3ea1226a06bcd76efb947059835a6b297e7014a637d555dd632c56d1630e5::cxvcv {
    struct CXVCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXVCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXVCV>(arg0, 9, b"CXVCV", b"SDD", b"ASDASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84d42630-c67a-41bd-a247-2e65f9cac89c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXVCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXVCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

