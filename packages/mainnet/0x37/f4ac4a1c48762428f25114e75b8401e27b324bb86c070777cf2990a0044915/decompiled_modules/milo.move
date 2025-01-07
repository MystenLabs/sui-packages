module 0x37f4ac4a1c48762428f25114e75b8401e27b324bb86c070777cf2990a0044915::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 6, b"MILO", b"Taylor Mathis Dog", x"5461796c6f72204d617468697320446f6720287469636b65723a204d494c4f290a68747470733a2f2f782e636f6d2f544d61746853706f7274732f7374617475732f313831323631353031353233383937393836312f70686f746f2f33", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/milo_e9473fdd04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

