module 0x4c33b3fbf830f1039bc1e4e3cc39ae2c268ab060509b4d3d935eb27c3a88f434::hhaSUI {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hhaSUI", b"hhaSUI Coin", b"hhaSUI Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/images/stsui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

