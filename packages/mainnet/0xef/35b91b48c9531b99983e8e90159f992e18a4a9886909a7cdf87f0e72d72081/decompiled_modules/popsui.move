module 0xef35b91b48c9531b99983e8e90159f992e18a4a9886909a7cdf87f0e72d72081::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"POPSUICAT", x"24504f5053554920697320612063727970746f63757272656e63792070726f6a65637420696e737069726564206279206120766972616c20696e7465726e6574206d656d6520666561747572696e67206120646f6d65737469632073686f72742d68616972656420636174206e616d6564204f61746d65616c2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2a7f1ea2d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

