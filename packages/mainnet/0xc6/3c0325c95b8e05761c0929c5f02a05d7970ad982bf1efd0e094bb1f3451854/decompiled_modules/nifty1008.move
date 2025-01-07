module 0xc63c0325c95b8e05761c0929c5f02a05d7970ad982bf1efd0e094bb1f3451854::nifty1008 {
    struct NIFTY1008 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIFTY1008, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIFTY1008>(arg0, 6, b"NIFTY1008", b"NIFTY1008SUI", x"486f6c64206f6e2074696768742c2062656361757365206c696b65204e696674792c2069747320612077696c6420726964656578636570742077697468206d6f7265206d656d657320616e642066657765722066696e616e6369616c2061647669736f7273210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_17_52_39_27b1197383.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIFTY1008>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIFTY1008>>(v1);
    }

    // decompiled from Move bytecode v6
}

